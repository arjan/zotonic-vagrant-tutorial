{% extends "page.tpl" %}

{% block main %}

	{% include "_meta.tpl" %}
    
    <p><b>{{ id.summary }}</b></p>

    {{ id.body|show_media }}

    <hr />

    Let's do some stuff here!
    
{% endblock %}
