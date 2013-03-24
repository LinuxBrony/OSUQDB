# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".up").on("click", ->
    id = $(this).parent().attr("id")

    if $("#" + id + " > .down").hasClass("down_voted")
      $.ajax({
        type: "POST",
        url: "/quotes/" + id + "/vote/change",
        data: {
          upvote: true 
        },
        success: -> 
          $("#" + id + " > .up").addClass("up_voted")
          $("#" + id + " > .down").removeClass("down_voted")
          num = Number($("#" + id + " > .num").text())
          num = num + 2
          $("#" + id + " > .num").text(num)
      })
    else
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

  $(".down").on("click", ->
    id = $(this).parent().attr("id")

    if $("#" + id + " > .up").hasClass("up_voted")
      $.ajax({
        type: "POST",
        url: "/quotes/" + id + "/vote/change",
        data: {
          upvote: false
        },
        success: -> 
          $("#" + id + " > .down").addClass("down_voted")
          $("#" + id + " > .up").removeClass("up_voted")
          num = Number($("#" + id + " > .num").text())
          num = num - 2
          $("#" + id + " > .num").text(num)
      })
    else
      $.ajax({
        type: "POST",
        url: "/quotes/" + id + "/vote",
        data: {
          upvote: false
        },
        success: -> 
          $("#" + id + " > .down").addClass("down_voted")
          num = Number($("#" + id + " > .num").text())
          num = num - 1
          $("#" + id + " > .num").text(num)
      })
  )
