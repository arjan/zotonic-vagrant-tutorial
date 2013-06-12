{% extends "page.tpl" %}

{% block main %}

	{% include "_meta.tpl" %}
    
    <p><b>{{ id.summary }}</b></p>

    {{ id.body|show_media }}

    <hr />
    <h2>Give us some feedback</h2>
    <p class="alert alert-info">We'd love it if you give some feedback on this project! Enter your email address and your message in the form below.</p>

    {% wire id=#form type="submit" postback={feedback_form} delegate="tutorial" %}
    <form id="{{ #form }}" action="postback" method="post">
        <div class="control-group">
            <div class="controls">
                <input name="email" id="email" placeholder="Email address"></textarea>
                {% validate id="email" type={presence} type={email} %}
            </div>
        </div>

        <div class="control-group">
            <div class="controls">
                <textarea name="message" id="message" placeholder="Enter your feedback..."></textarea>
            </div>
        </div>
        
        <div class="control-group">
            <button class="btn btn-primary">Submit form</button>
        </div>
    </form>
    <hr />

    {# loop over the images #}
    {% for id in id.o.depiction %}
        {% image id width=200 %}
    {% endfor %}
    
{% endblock %}
