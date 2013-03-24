# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".up").on("click", ->
    id = $(this).parent().attr("id")
    $.ajax({
      type: "POST",
      url: "/quotes/" + id + "/vote",
      data: {
        upvote: true
      },
      success: -> 
        $("#" + id + " > .up").addClass("up_voted")
        num = Number($("#" + id + " > .num").text())
        num = num + 1
        $("#" + id + " > .num").text(num)
    })
  )
