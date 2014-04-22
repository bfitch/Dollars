$(document).ready(function() {
  $('.typeahead').typeahead({
    highlight: true,
    minLength: 2
  }, {
    name:        'payees',
    displayKey:  'name',
    source:      onSelect
  }).on('typeahead:selected', function(x, data) {
    $('#payee_name').val(data.name);
  });

  function callback(data){};

  function onSelect(query, callback) {
    var deferred = $.get('payees/autocomplete?q=' + query);
    deferred.success(function(data){
      callback(data);
    });
  };
});
