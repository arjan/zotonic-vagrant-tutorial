{% extends "page.tpl" %}

{% block content %}
    Hello, this is a project

    My title is:
    <h1>{{ id.title }}</h1>

    Another way to put that:
    <h1>{{ m.rsc[id].title }}</h1>

    (which explicitly uses the "m_rsc" model)
{% endblock %}
