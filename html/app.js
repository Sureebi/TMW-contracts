$(function () {
  var closestid;
  var closestveh;
  var salePrice = 0;
  
  window.addEventListener('message', function (event) {
    switch (event.data.action) {
      case 'opencontract':
        $('.framereceiver #text').text(event.data.playername);
        $('.frameplate #text').text(event.data.plate);
        $('.framereceiver #sign').text(event.data.name);
        $('.container').show();
        $('#price-input').val('');
        closestid = event.data.closestid;
        closestveh = event.data.plate;
        salePrice = 0;
        break;
    }
  });
  
  // Форматиране на цената с разделители
  function formatPrice(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
  
  // Валидация на цената
  $('#price-input').on('input', function() {
    let value = $(this).val().replace(/[^0-9]/g, '');
    if (value.length > 9) {
      value = value.substring(0, 9);
    }
    $(this).val(value);
  });
  
  $('#transfer-button').on('click', function () {
    salePrice = parseInt($('#price-input').val()) || 0;
    
    if (salePrice <= 0) {
      // Можеш да добавиш notification тук
      return;
    }
    
    sound();
    $('#price-display').text(formatPrice(salePrice));
    $('.container2 .frameplate #text').text(closestveh);
    $(".container").hide();
    $(".container2").show();
  });
  
  $('#cancel-button').on('click', function () {
    sound();
    $(".container").hide();
    $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
  });
  
  $('#back-button').on('click', function () {
    sound();
    $(".container2").hide();
    $(".container").show();
  });
  
  $('#confirm-button').on('click', function () {
    sound();
    $(".container2").hide();
    $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
    $.post(`https://${GetParentResourceName()}/writecontract`, JSON.stringify({
      closestplayer: closestid, 
      plate: closestveh,
      price: salePrice
    }));
  });
  
  $(document).ready(function () {
    document.onkeyup = function (data) {
      if (data.which == 27) {
        $('.container').hide();
        $('.container2').hide();
        $.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
      }
    };
  });
  
  function sound() {
    document.getElementById('sound').pause();
    document.getElementById('sound').currentTime = 0;
    document.getElementById('sound').volume = 0.5;
    document.getElementById('sound').play();
  }
})