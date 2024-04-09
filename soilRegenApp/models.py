#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
import requests
import pandas as pd
import pymysql
from django import forms
from django.conf import settings
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import Permission
from django.contrib.auth.models import User
from django.db import IntegrityError
from django.db import transaction
from django.db import models
from django.shortcuts import render, redirect
from django.urls import reverse
from math import isnan

pymysql.install_as_MySQLdb()

# migrations updated 07/19 6 pm.  All models are now managed by Django.

class Amendment(models.Model):
    amendment_id = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=50, blank=True, null=True)
    brand_name = models.CharField(max_length=50, blank=True, null=True)
    country = models.ForeignKey('Country', models.DO_NOTHING, blank=True, null=True)
    organic = models.IntegerField(blank=True, null=True)
    organic_certified = models.IntegerField(blank=True, null=True)
    cat = models.ForeignKey('AmendmentCategory', models.DO_NOTHING, blank=True, null=True)
    type = models.ForeignKey('AmendmentType', models.DO_NOTHING, blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        
        db_table = 'amendment'


class AmendmentCategory(models.Model):
    cat_id = models.AutoField(primary_key=True)
    category_name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        
        db_table = 'amendment_category'


class AmendmentElement(models.Model):
    amendment_element_id = models.AutoField(primary_key=True)
    quantity = models.FloatField(blank=True, null=True)
    units = models.CharField(max_length=20, blank=True, null=True)
    amendment = models.ForeignKey(Amendment, models.DO_NOTHING, blank=True, null=True)
    element = models.ForeignKey('Element', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        
        db_table = 'amendment_element'
        unique_together = ('amendment', 'element')


class AmendmentType(models.Model):
    type_id = models.AutoField(primary_key=True)
    type_name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        
        db_table = 'amendment_type'


class Analysis(models.Model):
    analysis_id = models.AutoField(primary_key=True)
    analysis_date = models.DateField(blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    soil_report = models.ForeignKey('SoilReport', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        
        db_table = 'analysis'


class AnalysisItem(models.Model):
    item_id = models.AutoField(primary_key=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    analysis = models.ForeignKey(Analysis, models.DO_NOTHING, blank=True, null=True)
    report_item = models.ForeignKey('ReportItem', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        
        db_table = 'analysis_item'


class Comment(models.Model):
    comment_id = models.AutoField(primary_key=True)
    user = models.ForeignKey('UserProfile', on_delete=models.CASCADE, db_index=True)
    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE, db_index=True, blank=True, null=True)
    amendment = models.ForeignKey('Amendment', on_delete=models.CASCADE, db_index=True, blank=True, null=True)
    comment_text = models.CharField(max_length=255, null=False)

    class Meta:
        
        db_table = 'comment'


class Country(models.Model):
    country_id = models.AutoField(primary_key=True)
    country_name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        
        db_table = 'country'


class Element(models.Model):
    element_id = models.AutoField(primary_key=True)
    element_name = models.CharField(max_length=50, blank=True, null=True)
    common_name = models.CharField(max_length=50, blank=True, null=True)
    element_symbol = models.CharField(max_length=20, blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        
        db_table = 'element'


class Farm(models.Model):
    farm_id = models.AutoField(primary_key=True)
    farm_name = models.CharField(max_length=50, blank=True, null=True)
    street_address = models.CharField(max_length=50, blank=True, null=True)
    town = models.CharField(max_length=50, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    zip = models.CharField(max_length=5, blank=True, null=True)
    state = models.CharField(max_length=2, blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    user = models.ForeignKey('auth.User', on_delete=models.CASCADE, null=True)

    class Meta:
        
        db_table = 'farm'


class Field(models.Model):
    field_id = models.AutoField(primary_key=True)
    field_name = models.CharField(max_length=50, blank=True, null=True)
    field_acres = models.FloatField(blank=True, null=True)
    soil_type = models.CharField(max_length=50, blank=True, null=True)
    growing_zone = models.IntegerField(blank=True, null=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    farm = models.ForeignKey(Farm, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        
        db_table = 'field'


class RecipeType(models.Model):
    recipe_type_id = models.AutoField(primary_key=True)
    recipe_type_name = models.CharField(max_length=45, blank=True, default='')

    def __str__(self):
        return self.recipe_type_name
    
    class Meta:

        db_table = 'recipe_type'


class RecipeCategory(models.Model):
    recipe_category_id = models.AutoField(primary_key=True)
    recipe_category_name = models.CharField(max_length=45, blank=True, default='')

    def __str__(self):
        return self.recipe_category_name
    
    class Meta:
        
        db_table = 'recipe_category'
        

class Application(models.Model):
    application_id = models.AutoField(primary_key=True)
    application_name = models.CharField(max_length=20, blank=True, default='')

    def __str__(self):
        return self.application_name
    
    class Meta:

        db_table = 'application'


class Practice(models.Model):
    practice_id = models.AutoField(primary_key=True)
    practice_name = models.CharField(max_length=20, blank=True, default='')
    practice_description = models.CharField(max_length=100, blank=True, default='')

    def __str__(self):
        return self.practice_name
    
    class Meta:

        db_table = 'practice'


class Unit(models.Model):
    unit_id = models.AutoField(primary_key=True)
    unit_name = models.CharField(max_length=45, blank=True, default='')

    def __str__(self):
        return self.unit_name
    
    class Meta:

        db_table = 'unit'
        
        
class Ingredient(models.Model):
    
    ingredient_id = models.AutoField(primary_key=True)
    ingredient_name = models.CharField(max_length=45, blank=True, default='')
    ingredient_description = models.CharField(max_length=100, blank=True, default='')
    practice = models.ForeignKey('Practice', models.DO_NOTHING, blank=True, default='')
    ingredient_category = models.ForeignKey('IngredientCategory', models.DO_NOTHING, blank=True, default='')
    ingredient_type = models.ForeignKey('IngredientType', models.DO_NOTHING, blank=True, default='')

    def __str__(self):
        return self.ingredient_name

    class Meta:

        db_table = 'ingredient'


class IngredientCategory(models.Model):
    cat_id = models.AutoField(primary_key=True)
    category_name = models.CharField(max_length=45, blank=True, default='')

    def __str__(self):
        return self.category_name
    
    class Meta:

        db_table = 'ingredient_category'


class IngredientType(models.Model):
    ingredient_type_id = models.AutoField(primary_key=True)
    ingredient_type_name = models.CharField(max_length=45, blank=True, default='')

    def __str__(self):
        return self.ingredient_type_name
    
    class Meta:

        db_table = 'ingredient_type'
        
        
class Recipe(models.Model):
    recipe_id = models.AutoField(primary_key=True)
    recipe_name = models.CharField(max_length=45, blank=True, default='')
    recipe_description = models.CharField(max_length=100, blank=True, default='')
    recipe_type = models.ForeignKey('RecipeType', on_delete=models.DO_NOTHING, db_index=True)
    recipe_category = models.ForeignKey('RecipeCategory', on_delete=models.DO_NOTHING, db_index=True)
    practice = models.ForeignKey('Practice', on_delete=models.DO_NOTHING, db_index=True)
    application = models.ForeignKey('Application', on_delete=models.DO_NOTHING, db_index=True)
    recipe_rate = models.FloatField(blank=True, default=0.0)
    unit = models.ForeignKey('Unit', on_delete=models.DO_NOTHING, db_index=True)
    recipe_notes = models.CharField(max_length=255, blank=True, default='')
    user = models.ForeignKey('UserProfile', on_delete=models.CASCADE, db_index=True)

    class Meta:
        db_table = 'recipe'


class RecipeIngredient(models.Model):
    recipe_ingredient_id = models.AutoField(primary_key=True)
    recipe_ingredient_quantity = models.FloatField(blank=True, default='0')
    unit = models.ForeignKey('Unit', on_delete=models.DO_NOTHING, db_index=True)
    source = models.ForeignKey('Source', on_delete=models.DO_NOTHING, db_index=True)
    recipe_ingredient_notes = models.CharField(max_length=255, blank=True, null=True)
    recipe = models.ForeignKey(Recipe, models.CASCADE, db_index=True)
    ingredient = models.ForeignKey(Ingredient, models.DO_NOTHING, db_index=True)

    class Meta:

        db_table = 'recipe_ingredient'


class RecipeStep(models.Model):
    recipe_step_id = models.AutoField(primary_key=True)
    recipe_step_number = models.IntegerField(blank=True, default='0')
    recipe_step_name = models.CharField(max_length=50, blank=True, default='')
    recipe_step_description = models.CharField(max_length=100, blank=True, default='')
    recipe_step_notes = models.CharField(max_length=255, blank=True, null=True)
    recipe = models.ForeignKey(Recipe, models.CASCADE, db_index=True)

    class Meta:
        
        db_table = 'recipe_step'
        
        
class ReportItem(models.Model):
    item_id = models.AutoField(primary_key=True)
    tested_element = models.CharField(max_length=100, blank=True, null=True)
    unit = models.CharField(max_length=20, blank=True, null=True)
    results = models.FloatField(blank=True, null=True)
    target_ratio = models.FloatField(blank=True, null=True)
    target_level = models.FloatField(blank=True, null=True)
    report = models.ForeignKey('SoilReport', models.DO_NOTHING, db_index=True)

    class Meta:
        
        db_table = 'report_item'


class SoilReport(models.Model):
    report_id = models.AutoField(primary_key=True)
    report_date = models.DateField(blank=True, null=True)
    lab_name = models.CharField(max_length=50, blank=True, null=True)
    field = models.ForeignKey(Field, models.DO_NOTHING,  db_index=True)

    class Meta:
        
        db_table = 'soil_report'


class Source(models.Model):
    source_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=45, blank=True, default='0')
    notes = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return self.name
    
    class Meta:
        
        db_table = 'source'


class SourceAmendment(models.Model):
    source_amendment_id = models.AutoField(primary_key=True)
    source = models.ForeignKey(Source, models.DO_NOTHING, blank=True, null=True)
    amendment = models.ForeignKey(Amendment, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        
        db_table = 'source_amendment'
        unique_together = ('source', 'amendment')
        
        
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, default=None)
    street_address = models.CharField(max_length=50, blank=True, null=False, default='123 Main St')
    town = models.CharField(max_length=50, blank=True, null=False, default='Maidstone')
    state = models.CharField(max_length=2, blank=True, null=False, default='VT')
    zip = models.CharField(max_length=5, blank=True, null=False, default='05905')
    phone = models.CharField(max_length=10, blank=True, null=True)
    notes = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'user_profile'


