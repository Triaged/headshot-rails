Messaging.Thread = DS.Model.extend({
    title: DS.attr('string'),
    members: DS.attr('boolean'),
    messages: DS.hasMany('message')
});

Messaging.Thread.FIXTURES = [
    { id: 1, title: "Hi", messages: [1,2] },
    { id: 2, title: "Bye", messages: [3,4] }
];
