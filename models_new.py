from sqlalchemy_serializer import SerializerMixin
from datetime import datetime
import app

class Indicator(app.db.Model, SerializerMixin):
    __tablename__ = 'indicator'
    id = app.db.Column(app.db.Integer, primary_key=True)
    unique_key = app.db.Column(app.db.String(32))
    name = app.db.Column(app.db.String(255))
    short_name = app.db.Column(app.db.String(255))
    valid = app.db.Column(app.db.Boolean)
    created_at = app.db.Column(app.db.DateTime())
    last_updated_at = app.db.Column(app.db.DateTime())

    sources = app.db.relationship('IndicatorSources', backref='indicator')
    params = app.db.relationship('IndicatorParams', backref='indicator')
    outputs = app.db.relationship('IndicatorOutputs', backref='indicator')
    
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

class IndicatorSources(app.db.Model, SerializerMixin):
    __tablename__ = 'indicator_sources'

    id = app.db.Column(app.db.Integer, primary_key=True)
    indicator_id = app.db.Column(app.db.Integer, app.db.ForeignKey('indicator.id'))
    name = app.db.Column(app.db.String(255))
    type = app.db.Column(app.db.String(255))
    box_type = app.db.Column(app.db.String(255))
    min_value = app.db.Column(app.db.Float)
    max_value = app.db.Column(app.db.Float)
    values = app.db.Column(app.db.String(255)) # Try to change it to list, enum or pickleable


class IndicatorParams(app.db.Model, SerializerMixin):
    __tablename__ = 'indicator_params'

    id = app.db.Column(app.db.Integer, primary_key=True)
    indicator_id = app.db.Column(app.db.Integer, app.db.ForeignKey('indicator.id'))
    name = app.db.Column(app.db.String(255))
    type = app.db.Column(app.db.String(255))
    box_type = app.db.Column(app.db.String(255))
    min_value = app.db.Column(app.db.Float)
    max_value = app.db.Column(app.db.Float)


class IndicatorOutputs(app.db.Model, SerializerMixin):
    __tablename__ = 'indicator_outputs'

    id = app.db.Column(app.db.Integer, primary_key=True)
    indicator_id = app.db.Column(app.db.Integer, app.db.ForeignKey('indicator.id'))
    name = app.db.Column(app.db.String(255))
