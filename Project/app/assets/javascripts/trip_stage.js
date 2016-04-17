$(document).on('ready page:load', function () {

    $('.article-comment-ctrl').click(function(){
        var article_comments = $(this).parent().find('.article-comments');

        var defaultHeight = article_comments.height();
        article_comments.css('height', 'auto');

        var autoHeight = article_comments.height();

        article_comments.css('height', defaultHeight);

        article_comments.animate({height: autoHeight}, 200);

        $(this).animate({opacity: 0}, 200);
    });
});