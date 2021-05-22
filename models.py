from sqlalchemy_serializer import SerializerMixin
from datetime import datetime
from app import db

class Indicator(db.Model, SerializerMixin):
    __tablename__ = 'indicator'

    id = db.Column(db.Integer, primary_key=True)
    unique_key = db.Column(db.String(32))
    name = db.Column(db.String(255))
    short_name = db.Column(db.String(255))
    valid = db.Column(db.Boolean)
    created_at = db.Column(db.DateTime())
    last_updated_at = db.Column(db.DateTime())

    sources = db.relationship('IndicatorSources', backref='indicator')
    params = db.relationship('IndicatorParams', backref='indicator')
    outputs = db.relationship('IndicatorOutputs', backref='indicator')
    
    serialize_only = (
        'unique_key', 
        'name', 
        'short_name', 
        'valid', 
        'sources.name',
        'sources.type',
        'sources.box_type',
        'sources.min_value',
        'sources.max_value',
        'sources.values',
        'params.name',
        'params.type',
        'params.box_type',
        'params.min_value',
        'params.max_value',
        'outputs.name'
    )
    
    serialize_rules = (
        '-sources.indicator.sources',
        '-params.indicator.params',
        '-outputs.indicator.outputs'
    )

class IndicatorSources(db.Model, SerializerMixin):
    __tablename__ = 'indicator_sources'

    id = db.Column(db.Integer, primary_key=True)
    indicator_id = db.Column(db.Integer, db.ForeignKey('indicator.id'))
    name = db.Column(db.String(255))
    type = db.Column(db.String(255))
    box_type = db.Column(db.String(255))
    min_value = db.Column(db.Float)
    max_value = db.Column(db.Float)
    values = db.Column(db.String(255))

class IndicatorParams(db.Model, SerializerMixin):
    __tablename__ = 'indicator_params'

    id = db.Column(db.Integer, primary_key=True)
    indicator_id = db.Column(db.Integer, db.ForeignKey('indicator.id'))
    name = db.Column(db.String(255))
    type = db.Column(db.String(255))
    box_type = db.Column(db.String(255))
    min_value = db.Column(db.Float)
    max_value = db.Column(db.Float)

class IndicatorOutputs(db.Model, SerializerMixin):
    __tablename__ = 'indicator_outputs'

    id = db.Column(db.Integer, primary_key=True)
    indicator_id = db.Column(db.Integer, db.ForeignKey('indicator.id'))
    name = db.Column(db.String(255))

class Logic(db.Model, SerializerMixin):
    __tablename__ = 'logic'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))

    inputs = db.relationship('LogicInputs', backref='logic')
    outputs = db.relationship('LogicOutputs', backref='logic')
    
    serialize_only = (
        'name', 
        'inputs.name',
        'outputs.name'
    )
    
    serialize_rules = (
        '-inputs.logic.inputs',
        '-outputs.logic.outputs'
    )

class LogicInputs(db.Model, SerializerMixin):
    __tablename__ = 'logic_inputs'

    id = db.Column(db.Integer, primary_key=True)
    logic_id = db.Column(db.Integer, db.ForeignKey('logic.id'))
    name = db.Column(db.String(255))

class LogicOutputs(db.Model, SerializerMixin):
    __tablename__ = 'logic_outputs'

    id = db.Column(db.Integer, primary_key=True)
    logic_id = db.Column(db.Integer, db.ForeignKey('logic.id'))
    name = db.Column(db.String(255))



class Action(db.Model, SerializerMixin):
    __tablename__ = 'action'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))

    inputs = db.relationship('ActionInputs', backref='action')
    params = db.relationship('ActionParams', backref='action')
    
    serialize_only = (
        'name', 
        'inputs.name',
        'params.name'
    )
    
    serialize_rules = (
        '-inputs.action.inputs',
        '-params.action.params',
    )

class ActionInputs(db.Model, SerializerMixin):
    __tablename__ = 'action_inputs'

    id = db.Column(db.Integer, primary_key=True)
    action_id = db.Column(db.Integer, db.ForeignKey('action.id'))
    name = db.Column(db.String(255))

class ActionParams(db.Model, SerializerMixin):
    __tablename__ = 'action_params'

    id = db.Column(db.Integer, primary_key=True)
    action_id = db.Column(db.Integer, db.ForeignKey('action.id'))
    name = db.Column(db.String(255))
    type = db.Column(db.String(255))
    box_type = db.Column(db.String(255))
    min_value = db.Column(db.Float)
    max_value = db.Column(db.Float)
