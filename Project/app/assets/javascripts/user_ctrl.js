$(document).on('ready page:load', function () {

	$('#user-pannel').css('height', 0);

	$('#button-open-pannel').click(function(){

		var pannel = $('#user-pannel');

		var defaultHeight = pannel.height();
		pannel.css('height', 'auto');

		var autoHeight = pannel.height();
		if(defaultHeight != 0){
			autoHeight = 0;
		}
		

		pannel.css('height', defaultHeight);

		pannel.animate({height: autoHeight}, 200);
	});
});