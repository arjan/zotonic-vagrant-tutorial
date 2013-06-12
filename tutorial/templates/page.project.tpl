{% extends "page.tpl" %}

{% block main %}

	{% include "_meta.tpl" %}
    
    <p><b>{{ id.summary }}</b></p>

    {{ id.body|show_media }}

    <hr />
    <div id="feedback-area">
        {% include "_feedback_form.tpl" %}
    </div>
    <hr />

    {# loop over the images #}
    {% for id in id.o.depiction %}
        {% image id width=200 %}
    {% endfor %}
    
{% endblock %}
