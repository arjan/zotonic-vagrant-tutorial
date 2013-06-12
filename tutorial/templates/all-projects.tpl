{% extends "base.tpl" %}

{% block main %}

    <h1>A listing of all projects</h1>

    <ul>
        {% for id in  m.search[{query cat='project' sort='-publication_start'}] %}
            <li>
                <a href="{{ id.page_url }}">{{ id.title }}</a>
                <span>{{ id.summary }}</span>
            </li>
        {% endfor %}
    </ul>

{% endblock %}
