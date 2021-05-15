from sqlalchemy_serializer import SerializerMixin
from datetime import datetime
from app import db, ma

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
    values = db.Column(db.String(255)) # Try to change it to list, enum or pickleable


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
