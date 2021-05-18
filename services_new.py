import os
import sys
sys.path.append(os.path.dirname(__file__))
from config import DB
from sqlalchemy import exc
#from models import Indicator, IndicatorSources, IndicatorParams, IndicatorOutputs
import models

from flask.json import jsonify
from sqlalchemy.exc import IntegrityError
import app

from datetime import datetime
import pandas as pd
import numpy as np
import tulipy as ti
import hashlib
import json


def validate_indicator(payload):
    test_indicator = models.Indicator()
    payload['real'] = np.array(payload.pop('source'))

    try:
        short_name = payload.pop('short_name')
        indicator_func = getattr(ti, short_name)
        output = indicator_func(**payload)
        
        output = output.tolist() if type(output) == 'ndarray' else [out.tolist() for out in output]
        
        test_indicator.unique_key = hashlib.md5(indicator_func.full_name.encode()).hexdigest()
        test_indicator.name = indicator_func.full_name
        test_indicator.short_name = short_name
        test_indicator.valid = True
        test_indicator.created_at = datetime.datetime.utcnow()
        test_indicator.last_updated_at = datetime.datetime.utcnow()

        try:
            app.db.create_all()
            app.db.session.add(test_indicator)
            app.db.session.commit()
            return {"indicator": test_indicator, "data": output}
        except Exception as e:
            app.db.session.rollback()
            test_indicator_update = test_indicator.query.filter_by(unique_key=test_indicator.unique_key).first()
            test_indicator_update.valid = test_indicator.valid
            test_indicator_update.last_updated_at = datetime.datetime.utcnow()
            app.db.session.commit()
            return {"indicator": test_indicator_update, "data": output}

    except AttributeError:
        output = f"Indicator {short_name} not present in Tulip library"
        test_indicator.valid = False
        return {"indicator": test_indicator, "data": output}

    except TypeError as e:
        output = str(e)
        test_indicator.valid = False
        return {"indicator": test_indicator, "data": output}

def get_metadata(short_name):
    indicator = getattr(ti,short_name)
    return {
        "Type": indicator.type,
        "Inputs": ', '.join(indicator.inputs),
        "Options": ', '.join(indicator.options),
        "Outputs": ', '.join(indicator.outputs)
    } 

def create_indicator(short_name):
    indicator_func = getattr(ti, short_name)
    
    indicator = models.Indicator(
        name=indicator_func.full_name,
        unique_key=hashlib.md5(indicator_func.full_name.encode()).hexdigest(),
        short_name=short_name,
        valid=True,
        created_at=datetime.utcnow(), 
        last_updated_at=datetime.utcnow()
    )
    
    indicator_sources = []
    for source in indicator_func.inputs:
        box_type = "Text Box" if source != "real" else "Dropdown"
        values = None if source != "real" else "Open, High, Low, Close"

        indicator_sources.append(
            models.IndicatorSources(
                indicator = indicator,
                name = source,
                type = "Float",
                box_type = box_type,
                min_value = 0,
                max_value = 1_000_000,
                values = values
            )
        )

    indicator_params = []
    for param in indicator_func.options:
        indicator_params.append(
            models.IndicatorParams(
                indicator = indicator,
                name = param,
                type = "Float",
                box_type = "Text Box",
                min_value = 0,
                max_value = 1_000_000,
            )
        )

    indicator_outputs = []
    for output in indicator_func.outputs:
        indicator_outputs.append(
            models.IndicatorOutputs(
                indicator = indicator,
                name = output
            )
        )

    app.db.create_all()
    app.db.session.add(indicator)
    app.db.session.add_all(indicator_sources)
    app.db.session.add_all(indicator_params)
    app.db.session.add_all(indicator_outputs)

    app.db.session.commit()

    return indicator.to_dict()

def get_indicators_metadata(short_name):
    indicators = models.Indicator.query.filter_by(short_name = short_name).all() if short_name is not None else models.Indicator.query.all()
    
    output = []
    for indicator in indicators:
        indicator = indicator.to_dict()
        for source in indicator['sources']:
            try: source['values'] = source['values'].split(',')
            except: pass
    
        indicator['inputs'] = {'name': 'input'}
        output.append(indicator)
    

    return output

def get_indicators(short_name):
    indicators = models.Indicator.query.filter_by(short_name = short_name).all() if short_name is not None else models.Indicator.query.all()
    
    output = []
    for indicator in indicators:
        indicator = indicator.to_dict()
        del indicator['sources']
        del indicator['valid']
        del indicator['params']
        del indicator['outputs']

        output.append(indicator)
    
    return output