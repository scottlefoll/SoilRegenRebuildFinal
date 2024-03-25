# Generated by Django 5.0.3 on 2024-03-25 13:30

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='AmendmentCategory',
            fields=[
                ('cat_id', models.AutoField(primary_key=True, serialize=False)),
                ('category_name', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'amendment_category',
            },
        ),
        migrations.CreateModel(
            name='AmendmentType',
            fields=[
                ('type_id', models.AutoField(primary_key=True, serialize=False)),
                ('type_name', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'amendment_type',
            },
        ),
        migrations.CreateModel(
            name='Analysis',
            fields=[
                ('analysis_id', models.AutoField(primary_key=True, serialize=False)),
                ('analysis_date', models.DateField(blank=True, null=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'analysis',
            },
        ),
        migrations.CreateModel(
            name='Country',
            fields=[
                ('country_id', models.AutoField(primary_key=True, serialize=False)),
                ('country_name', models.CharField(blank=True, max_length=50, null=True)),
            ],
            options={
                'db_table': 'country',
            },
        ),
        migrations.CreateModel(
            name='Element',
            fields=[
                ('element_id', models.AutoField(primary_key=True, serialize=False)),
                ('element_name', models.CharField(blank=True, max_length=50, null=True)),
                ('common_name', models.CharField(blank=True, max_length=50, null=True)),
                ('element_symbol', models.CharField(blank=True, max_length=20, null=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'element',
            },
        ),
        migrations.CreateModel(
            name='Recipe',
            fields=[
                ('recipe_id', models.AutoField(primary_key=True, serialize=False)),
                ('recipe_name', models.CharField(max_length=45)),
                ('recipe_notes', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'recipe',
            },
        ),
        migrations.CreateModel(
            name='ReportItem',
            fields=[
                ('item_id', models.AutoField(primary_key=True, serialize=False)),
                ('tested_element', models.CharField(blank=True, max_length=100, null=True)),
                ('unit', models.CharField(blank=True, max_length=20, null=True)),
                ('results', models.FloatField(blank=True, null=True)),
                ('target_ratio', models.FloatField(blank=True, null=True)),
                ('target_level', models.FloatField(blank=True, null=True)),
            ],
            options={
                'db_table': 'report_item',
            },
        ),
        migrations.CreateModel(
            name='Source',
            fields=[
                ('source_id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(blank=True, max_length=50, null=True)),
                ('contact_name', models.CharField(blank=True, max_length=50, null=True)),
                ('street_address', models.CharField(blank=True, max_length=50, null=True)),
                ('town', models.CharField(blank=True, max_length=50, null=True)),
                ('state', models.CharField(blank=True, max_length=2, null=True)),
                ('zip', models.CharField(blank=True, max_length=5, null=True)),
                ('phone', models.CharField(blank=True, max_length=10, null=True)),
                ('email', models.CharField(blank=True, max_length=100, null=True)),
                ('notes', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'source',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('user', models.OneToOneField(default=None, on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('street_address', models.CharField(blank=True, default='123 Main St', max_length=50)),
                ('town', models.CharField(blank=True, default='Maidstone', max_length=50)),
                ('state', models.CharField(blank=True, default='VT', max_length=2)),
                ('zip', models.CharField(blank=True, default='05905', max_length=5)),
                ('phone', models.CharField(blank=True, max_length=10, null=True)),
                ('notes', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'user_profile',
            },
        ),
        migrations.CreateModel(
            name='Amendment',
            fields=[
                ('amendment_id', models.AutoField(primary_key=True, serialize=False)),
                ('product_name', models.CharField(blank=True, max_length=50, null=True)),
                ('brand_name', models.CharField(blank=True, max_length=50, null=True)),
                ('organic', models.IntegerField(blank=True, null=True)),
                ('organic_certified', models.IntegerField(blank=True, null=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
                ('cat', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.amendmentcategory')),
                ('type', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.amendmenttype')),
                ('country', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.country')),
            ],
            options={
                'db_table': 'amendment',
            },
        ),
        migrations.CreateModel(
            name='Farm',
            fields=[
                ('farm_id', models.AutoField(primary_key=True, serialize=False)),
                ('farm_name', models.CharField(blank=True, max_length=50, null=True)),
                ('street_address', models.CharField(blank=True, max_length=50, null=True)),
                ('town', models.CharField(blank=True, max_length=50, null=True)),
                ('zip', models.CharField(blank=True, max_length=5, null=True)),
                ('state', models.CharField(blank=True, max_length=2, null=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'farm',
            },
        ),
        migrations.CreateModel(
            name='Field',
            fields=[
                ('field_id', models.AutoField(primary_key=True, serialize=False)),
                ('field_name', models.CharField(blank=True, max_length=50, null=True)),
                ('field_acres', models.FloatField(blank=True, null=True)),
                ('soil_type', models.CharField(blank=True, max_length=50, null=True)),
                ('growing_zone', models.IntegerField(blank=True, null=True)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
                ('farm', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.farm')),
            ],
            options={
                'db_table': 'field',
            },
        ),
        migrations.CreateModel(
            name='RecipeAmendment',
            fields=[
                ('recipe_amendment_id', models.AutoField(primary_key=True, serialize=False)),
                ('recipe_amendment_notes', models.CharField(blank=True, max_length=255, null=True)),
                ('amendment', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='soilRegenApp.amendment')),
                ('recipe', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='recipe_amendments', to='soilRegenApp.recipe')),
            ],
            options={
                'db_table': 'recipe_amendment',
            },
        ),
        migrations.CreateModel(
            name='AnalysisItem',
            fields=[
                ('item_id', models.AutoField(primary_key=True, serialize=False)),
                ('description', models.CharField(blank=True, max_length=255, null=True)),
                ('analysis', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.analysis')),
                ('report_item', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.reportitem')),
            ],
            options={
                'db_table': 'analysis_item',
            },
        ),
        migrations.CreateModel(
            name='SoilReport',
            fields=[
                ('report_id', models.AutoField(primary_key=True, serialize=False)),
                ('report_date', models.DateField(blank=True, null=True)),
                ('lab_name', models.CharField(blank=True, max_length=50, null=True)),
                ('field', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.field')),
            ],
            options={
                'db_table': 'soil_report',
            },
        ),
        migrations.AddField(
            model_name='reportitem',
            name='report',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.soilreport'),
        ),
        migrations.AddField(
            model_name='analysis',
            name='soil_report',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.soilreport'),
        ),
        migrations.AddField(
            model_name='recipe',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='soilRegenApp.userprofile'),
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('comment_id', models.AutoField(primary_key=True, serialize=False)),
                ('comment_text', models.CharField(max_length=255)),
                ('amendment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='soilRegenApp.amendment')),
                ('recipe', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='soilRegenApp.recipe')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='soilRegenApp.userprofile')),
            ],
            options={
                'db_table': 'comment',
            },
        ),
        migrations.CreateModel(
            name='AmendmentElement',
            fields=[
                ('amendment_element_id', models.AutoField(primary_key=True, serialize=False)),
                ('quantity', models.FloatField(blank=True, null=True)),
                ('units', models.CharField(blank=True, max_length=20, null=True)),
                ('amendment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.amendment')),
                ('element', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.element')),
            ],
            options={
                'db_table': 'amendment_element',
                'unique_together': {('amendment', 'element')},
            },
        ),
        migrations.CreateModel(
            name='SourceAmendment',
            fields=[
                ('source_amendment_id', models.AutoField(primary_key=True, serialize=False)),
                ('amendment', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.amendment')),
                ('source', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='soilRegenApp.source')),
            ],
            options={
                'db_table': 'source_amendment',
                'unique_together': {('source', 'amendment')},
            },
        ),
    ]
