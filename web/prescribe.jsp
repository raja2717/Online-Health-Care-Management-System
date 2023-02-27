<%-- 
    Document   : prescribe
    Created on : Feb 24, 2023, 2:29:33 PM
    Author     : anich
--%>
<%-- 
    Document   : prescription
    Created on : Feb 24, 2023, 10:40:06 AM
    Author     : anich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--done-->
        <link rel="stylesheet" href="css/owl.carousel.min.css"> 

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.login.css">

        <!-- Style -->
        <link rel="stylesheet" href="css/prescription.css">

    </head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
          integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
    crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/3.0.1/mustache.min.js"
    integrity="sha256-srhz/t0GOrmVGZryG24MVDyFDYZpvUH2+dnJ8FbpGi0=" crossorigin="anonymous"></script>
    <div class="wrapper">
        <div class="prescription_form">
            <table class="prescription" data-prescription_id="<?php echo $presc->prescription_id; ?>" border="1">
                <tbody>
                    <tr height="15%">
                        <td colspan="2">
                            <div class="header">
                                <div class="logo">
                                    <img
                                        src="https://seeklogo.com/images/H/hospital-clinic-plus-logo-7916383C7A-seeklogo.com.png" />
                                </div>
                                <div class="credentials">
                                    <h4>Doctor Name</h4>
                                    <p>Chamber Name</p>
                                    <small>Adress</small>
                                    <br />
                                    <small>Mb. 0XXXXXXXXX</small>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="40%">
                            <div class="desease_details">
                                <div class="symptoms">
                                    <h4 class="d-header">Symptoms</h4>
                                    <ul class="symp" data-toggle="tooltip" data-placement="bottom" title="Click to edit."
                                        contenteditable="true">
                                    </ul>
                                    <div class="symp_action">
                                        <button id="symp_save" data-prescription_id="<?php echo $presc->prescription_id; ?>" class="btn btn-sm btn-success save">Save</button>
                                        <button class="btn btn-sm btn-danger cancel-btn">Cancel</button>
                                    </div>
                                </div>
                                <div class="tests">
                                    <h4 class="d-header">Tests</h4>
                                    <ul class="tst" data-toggle="tooltip" data-placement="bottom" title="Click to edit."
                                        contenteditable="true">
                                    </ul>
                                    <div class="test_action">
                                        <button id="test_save" data-prescription_id="<?php echo $presc->prescription_id; ?>" class="btn btn-sm btn-success save">Save</button>
                                        <button class="btn btn-sm btn-danger cancel-btn">Cancel</button>
                                    </div>
                                </div>
                                <div class="advice">
                                    <h4 class="d-header">Advice</h4>
                                    <p class="adv_text" style="outline: 0;" data-toggle="tooltip"
                                       data-placement="bottom" title="Click to edit." contenteditable="true">
                                    </p>
                                    <div class="adv_action">
                                        <button id="adv_save" data-prescription_id="<?php echo $presc->prescription_id; ?>" class="btn btn-sm btn-success save">Save</button>
                                        <button class="btn btn-sm btn-danger cancel-btn">Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td width="60%" valign="top">
                            <span style="font-size: 3em;">R<sub>x</sub></span>
                            <hr />
                            <div class="medicine">
                                <section class="med_list">
                                </section>
                                <div id="add_med" data-toggle="tooltip" data-placement="right"
                                     title="Click anywhere on the blank space to add more.">Click to add...</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="button_group">
                <button class="issue_prescription btn btn-success">Issue</button>
                <!-- <button class="pdf_prescription btn btn-danger">PDF</button> -->
            </div>
            <div id="snacking">Saving...</div>
            <div id="snacked">Saved!</div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            Date.prototype.calcDate = function (days) {
                let date = new Date(this.valueOf());
                date.setDate(date.getDate() + days);
                return `(Untill ${date.getUTCDate()}-${date.getUTCMonth() +
                          1}-${date.getUTCFullYear()})`;
            };
            let timeout;
            function snackSaving() {
                let snack = document.getElementById("snacking");
                snack.className = "show";
                timeout = setTimeout(() => {
                    alert('ERR: Conection timeout.')
                }, 8000);
            }
            function snackSaved() {
                clearTimeout(timeout);
                let snack = document.getElementById("snacking");
                snack.className = snack.className.replace("show", "");
                let snacked = document.getElementById("snacked");
                snacked.className = "show";
                setTimeout(function () {
                    snacked.className = snacked.className.replace("show", "");
                }, 1500);
            }
            $("[data-toggle=tooltip]").tooltip("show");
            setTimeout(function () {
                $("[data-toggle=tooltip]").tooltip("hide");
            }, 5000); //hide tooltips after 5sec
            $(document).keyup(function () {
                $("[data-toggle=tooltip]").tooltip("hide");
            }); //hide tooltip while typing
            $(document).on("focusin keypress", ".med_name", function (e) {
                let x = $(this).siblings("div.med_name_action");
                if (e.type == "focusin") {
                    x.css("display", "block");
                }
                if (e.type == "keypress") {
                    if (e.keyCode == 13)
                        x.children("button.save").click();
                }
            });

            $(document).on("click", ".cancel-btn", function () {
                $(this)
                        .parent()
                        .css("display", "none"); //hides save/cancel btn
            });
            $(document).on("click", ".med_name_action button.save", function () {
                $(this)
                        .parent()
                        .css("display", "none");
                $(".sc_time").removeClass("folded");
            });
            $(".med_name").keypress(function (e) {
                if (e.which == 13) {
                    $("#symp_save").click();
                }
            });

            $(document).on("mousedown", ".sc", function (e) {
                let x = $(this).siblings("div.med_when_action");
                x.css("display", "block");
            });
            $(document).on("click", ".med_when_action button.save", function () {
                $(this)
                        .parent()
                        .css("display", "none");
                $(".select").removeClass("folded");
            });
            $("select.sc").change(function () {
                let x = $(this).siblings("div.med_when_action");
                x.css("display", "none");
            });

            $(document).on("mousedown", ".meal", function () {
                let x = $(this).siblings("div.med_meal_action");
                x.css("display", "block");
            });
            $(document).on("click", ".med_meal_action button.save", function () {
                $(this)
                        .parent()
                        .css("display", "none");
                $(".period").removeClass("folded");
            });

            $(document).on("focusin keypress", ".med_period", function (e) {
                let x = $(this).siblings("div.med_period_action");
                if (e.type == "focusin") {
                    x.css("display", "block");
                }
                if (e.type == "keypress") {
                    if (e.keyCode == 13)
                        x.children("button.save").click();
                }
            });
            $(document).on("click", ".med_period_action button.save", function () {
                $(this)
                        .parent()
                        .css("display", "none");
            });
            $(document).on("keyup", ".med_period", function () {
                let period = $(this).val();
                let num = +period.match(/\d+/g)[0];
                let type = period.match(/\b(\w)/g)[1];
                let days = null;
                if (type == "d")
                    days = num;
                else if (type == "w")
                    days = num * 7;
                else if (type == "m")
                    days = num * 30;
                else if (type == "y")
                    days = num * 365;
                let span = $(this).siblings("span.date");
                if (days) {
                    let date = new Date().calcDate(days);
                    span.html(date);
                } else {
                    span.html("(Invalid time period)");
                }
            });

            $(".sc").keyup(function (e) {
                if (isNaN(e.key))
                    return;
                let el = $(this);
                el = el
                        .val()
                        .split("-")
                        .join("");
                let finalVal = el.match(/.{1,1}/g).join("-");
                $(this).val(finalVal);
            });
            function initLi(e) {
                let txt = e.target.innerHTML;
                if (!txt.includes("<li>")) {
                    let el = "<li></li>";
                    $(this).append(el);
                }
            }
            $(".symptoms ul").focusin(initLi);
            $(".symptoms ul").keyup(function (e) {
                let fl = $(this)
                        .children()
                        .first();
                let el = `<li>${e.target.textContent}</li>`;
                if (fl.text().length < 1) {
                    $(this).html("");
                    $(this).append(el);
                }
            });
            $("#symp_save").click(function () {
                $(".symp_action").css("display", "none");
            });

            $(".tests ul").focusin(initLi);
            $(".tests ul").keyup(function () {
                let fl = $(this)
                        .children()
                        .first();
                let el = "<li></li>";
                if (fl.text().length < 1) {
                    $(this).html("");
                    $(this).append(el);
                }
            });
            $("#test_save").click(function () {
                $(".test_action").css("display", "none");
            });

            $(".symptoms ul").focusin(function () {
                $(".symp_action").css("display", "block");
            });

            $(".tests ul").focusin(function () {
                $(".test_action").css("display", "block");
            });

            $(".advice p").focusin(function () {
                $(".adv_action").css("display", "block");
            });

            $("#adv_save").click(function () {
                $(".adv_action").css("display", "none");
            });

            $(document).on("click", ".delete", function () {
                let parent = $(this).closest(".med");
                parent.remove();
            });

            let med_id = 1;
            $("#add_med").click(function () {
                med_id++;
                let sourceTemplate = $("#new_medicine").html();
                Mustache.parse(sourceTemplate);
                let sourceHTML = Mustache.render(sourceTemplate, {med_id});
                let medicine = $(".med_list");
                medicine.append(sourceHTML);
            })
        });


    </script>

    <script id="new_medicine" type="text/template">
        <div class="med">
        <input class="med_name" data-med_id="{{med_id}}" data-toggle="tooltip"
        title="Click to edit..." placeholder="Enter medicine name"/>
        <div class="med_name_action">
        <button data-med_id="{{med_id}}" class="btn btn-sm btn-success save">Save</button>
        <button class="btn btn-sm btn-danger cancel-btn">Cancel</button>
        </div>
        <div class="schedual">
        <div class="sc_time folded">
        <select class="sc" data-med_id="{{med_id}}">
        <option value="1+1+1" selected>1+1+1</option>
        <option value="1+0+1">1+0+1</option>
        <option value="0+1+1">1+1+1</option>
        <option value="1+0+0">1+1+1</option>
        <option value="0+0+1">1+1+1</option>
        <option value="1+1+1+1">1+1+1+1</option>
        </select>
        <div class="med_when_action">
        <button data-med_id="{{med_id}}"
        class="btn btn-sm btn-success save">&check;</button>
        </div>
        </div>
        <div class="taking_time select folded">
        <select class="meal" data-med_id="{{med_id}}">
        <option value="1" selected>After Meal</option>
        <option value="2">Before Meal</option>
        <option value="3">Take any time</option>
        </select>
        <div class="med_meal_action">
        <button data-med_id="{{med_id}}"
        class="btn btn-sm btn-success save">&check;</button>
        </div>
        </div>
        </div>
        <div class="med_footer">
        <div class="period folded">
        Take for <input class="med_period" type="text" data-med_id="{{med_id}}"
        placeholder="? days/weeks..." />
        <div class="med_period_action">
        <button data-med_id="{{med_id}}"
        class="btn btn-sm btn-success save">&check;</button>
        </div>
        <span class="date"></span>
        </div>
        <div class="del_action">
        <button data-med_id="{{med_id}}" class="btn btn-sm btn-danger delete"><i class="fa fa-trash"
        aria-hidden="true"></i></button>
        </div>
        </div>
        <hr />
        </div>
    </script>
