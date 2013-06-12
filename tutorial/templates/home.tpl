{% extends "base.tpl" %}

{% block title %}{{ m.site.title }}{% endblock %}

{% block main %}

    <div class="hero-unit">
        <h1>Welcome!</h1>
        <p>This is the home page for the Zotonic tutorial website.</p>

        {% button class="pull-right btn btn-primary btn-large" action={redirect dispatch=`admin`} text=_"Visit Admin Interface" %}
    </div>

    {# show the "body" field of the resource named "page_home"; and show the embedded images inline #}
    {{ m.rsc.page_home.body|show_media }}

    {# the button where you can edit the page #}
    {% button class="btn btn-info" action={redirect dispatch=`admin_edit_rsc` id=`page_home`} text=_"Edit this page" %}

{% endblock %}

{% block subnavbar %}
    {% include "_content_list.tpl" list=m.search[{query sort='-rsc.modified' pagelen=10}] title=_"Recent content" %}
{% endblock %}
