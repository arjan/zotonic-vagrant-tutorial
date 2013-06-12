{% extends "email_base.tpl" %}

{% block title %}Contact form submitted{% endblock %}

{% block body %}
    <p>Hello!</p>

    <p>The contact form on your site was submitted.</p>

    <p>The email address was: <b>{{ email|escape }}</b></p>

    <p>The message was: <b>{{ message|escape }}</b></p>

    <p>
        Kind regards,<br/>
        your website
    </p>
{% endblock %}
