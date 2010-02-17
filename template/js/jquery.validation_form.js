 jQuery.fn.validateThis = function(options) {

  settings = jQuery.extend(
  						  {
						       important_marker: "*",					 // этим будут помечены поля, обязательные для заполнения
							   min_pass: 6,								 // минимальная длина пароля
							   email_error_message: "некорректный email", // сообщение об ошибке в emaile
							   email_valid_message: "правильный email",  // сообщение о правильном emaile
							   pass_error_message: "пароли не совпадают", // сообщение о не совпадении паролей
							   pass_valid_message: "пароли совпадают",    // сообщение о совпадении паролей
							   container_valid_pass_width: 300,        // ширина (в пикселях) контейнера индикатора паролей
							   validPassMarker_dx: 20,                  // шаг индикатора паролей
							   validation_form: ".validation_form",      // класс проверяемой формы
							   focus: ".focus",      // класс поля, в который будет в фокусе при загрузке страницы
							   text: ".text",     						 // класс полей, подлежащих проверке
							   checkbox: ".checkbox",    				 // класс проверяемых чекбоксов
							   radio: ".radio",   				 		 // класс проверяемых радиокнопок
							   email: ".email",   						 // класс поля emaila
							   password1: ".password1",    				 // класс поля пароля, в котором проверяется длина пароля
							   password2: ".password2",    				 // класс поля подтверждения пароля
							   important: ".important",    				 // класс поля, обязательного для заполнения
				  			   submit: ".submit",
				  			   after_input: "p"                         // элемент добавляется после поля для вставки внего подсказок
						  }, options);

    //делаем кнопку submit неактивной
        $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", true);

         $(""+settings.validation_form+"").bind("submit",  function()
			{
				 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());
				 if(submit_on_off()==1)
				 {return false;}
			}
			)

     //Переносим фокус на выбранный элемент
        $(""+settings.validation_form+" "+settings.focus+"").focus();
        //$(""+settings.validation_form+" "+settings.focus+"").selected();

        var i=0;
        //устанавливаем значения по умолчанию для полей формы
          $(""+settings.validation_form+" "+settings.text+"").each(
				  function()
				  { i++;
				  		$(this).attr("value", $(this).attr("valNull") );
				        $(this).attr("idel", i);
				        $(this).attr("after_this", "after"+i+"");
				        $(this).attr("valid", "false");
				      	$(this).after("<"+settings.after_input+" id='after"+i+"' class='valid_after'> &nbsp; </"+settings.after_input+">");



                      $(this).addClass("value_Null");
                      //при приобретении элементом фокуса
				      $(this).bind("focus",  function()
											  {
											  	//если значение по-умолчанию
											  	if($(this).attr("value") == $(this).attr("valNull"))
											  		{
											  			$(this).attr("value", "" );
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_true");
											  			$(this).removeClass("value_false");
											  		 	$(this).addClass("value");
											  		}
											  	else//если пользовательское значение
											  		{
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_true");
											  			$(this).removeClass("value_false");
											  		 	$(this).addClass("value");
											  		}


                                                     // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());


											  } );
		//проверяем e-mail'ы
          $(""+settings.validation_form+" "+settings.email+"").each(
				  function()
				  {
				        $(this).bind("blur",  function()
											  {
                                                //если валидный email
											  	if( valid_email($(this).attr("value")) == true)
											  		{
											  			$(this).next().html("<div class='valid_message'>"+settings.email_valid_message+"</div>");
											  			$(this).removeClass("value");
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_false");
											  			$(this).addClass("value_true");
											  			$(this).attr("valid", "true");

											  	 	}
											  	else //если не валидный email
											  	{
											  			$(this).next().html("<div class='invalid_message'>"+settings.email_error_message+"</div>");
											  			$(this).removeClass("value");
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_true");
											  			$(this).attr("valid", "false");
											  			$(this).addClass("value_false");
											  	}
                                                 //если значение по-умолчанию или пусто
											  	if( $(this).attr("value") == "" || $(this).attr("value") == $(this).attr("valNull") )
											  		{
											  			$(this).attr("value", $(this).attr("valNull") );
											  			$(this).removeClass("value");
											  			$(this).removeClass("value_false");
											  			$(this).removeClass("value_true");
											  			$(this).attr("valid", "false");
											  		 	$(this).addClass("value_Null");
											  		}


											  } );

				  });//$("."+validation_form+" ."+email+"").each(

           //проверяем пароли на прочность
          $(""+settings.validation_form+" "+settings.password1+"").each(
				  function()
				  {
				        $(this).bind("keyup",  function()
											  {




                                                //если длина пароля больше или равна минимальной
											  	if( $(this).attr("value").length >= settings.min_pass)
											  		{
											  			$(this).next().html("<div class='container_valid_pass'><span class='validPassMarker'></span></div>");

											  			$(this).removeClass("value");
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_false");
											  			$(this).addClass("value_true");
											  			$(this).attr("valid", "true");

											  	 	}
											  	 else{

											  	      	$(this).next().html("<div class='container_valid_pass'><span class='validPassMarker'></span></div>");

											  			$(this).removeClass("value");
											  			$(this).removeClass("value_Null");
											  			$(this).removeClass("value_false");
											  			$(this).addClass("value_false");
											  			$(this).attr("valid", "false");
											  	 }
                                                    //высчитываем смещение индикатора в зависимости от количества символов в пароле
											     	var MARG_LEFT = settings.validPassMarker_dx*$(this).attr("value").length - settings.container_valid_pass_width;
											     	//если индикатор не полностью выдвинут, тогда выдвигаем
													if(MARG_LEFT<0)
													{
	                                                	$(".validPassMarker").animate({marginLeft: MARG_LEFT+"px"}, "fast");
	                                                	//.animate({"margin-left": "+=50px"}, "slow");
													}
													//если индикатор полностью выдвинут, тогда не выдвигаем
													if(MARG_LEFT>=0)
													{
													$(".validPassMarker").css("margin-left", "0px");
													}
													//задаем цвет индикатора в зависимости от количества символов
													if($(this).attr("value").length<4){$(".validPassMarker").css("background","#f00");}
													else if(($(this).attr("value").length>=4) && ($(this).attr("value").length<6)){$(".validPassMarker").css("background","#FF9F00");}
													else if(($(this).attr("value").length>=6) && ($(this).attr("value").length<8)){$(".validPassMarker").css("background","#CBFE01");}
													else if($(this).attr("value").length>=8){$(".validPassMarker").css("background","#0EFE01");}
                                                    //проверяем совпадают ли пароли
                                                    pass_ravno()

											   // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());

											  } );

				  });// $("."+validation_form+" ."+password1+"").each(



				  //проверяем совпадают ли пароли
          $(""+settings.validation_form+" "+settings.password2+"").each(
				  function()
				  {
				        $(this).bind("keyup",  function()
											  { //проверяем совпадают ли пароли
                                                pass_ravno();


											   // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());

											  } );

				  });// $("."+validation_form+" ."+password2+"").each(

                  //проверяем чекбоксы
          $(""+settings.validation_form+" "+settings.checkbox+"").each(
				  function()
				  {
				        $(this).bind("click",  function()
											  { 	//проверяем включен ли чекбокс
                                                		$(this).attr("valid", $(this).attr("checked"));

											   // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());

											  } );

				  });// $(".vali


				  //проверяем радиокнопки
          $(""+settings.validation_form+" "+settings.radio+"").each(
				  function()
				  {
				        $(this).bind("click",  function()
											  { 	//проверяем включена ли радиокнопка
                                                		$(this).attr("valid", $(this).attr("checked"));

											   // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());

											  } );

				  });// $(".vali


					  $(this).bind("blur",  function()
											  {  //если значение по-умолчанию или пусто
											  if( !$(this).hasClass("checkbox") && !$(this).hasClass("radio") && !$(this).hasClass("password1") && !$(this).hasClass("password2"))
                                               {
											  	if( $(this).attr("value") == "" || $(this).attr("value") == $(this).attr("valNull") )
											  		{
											  			$(this).attr("value", $(this).attr("valNull") );
											  			$(this).attr("valid", "false");
											  			$(this).removeClass("value");
											  			$(this).removeClass("value_true");
											  			$(this).removeClass("value_false");
											  		 	$(this).addClass("value_Null");
											  		}

											  	else
											  		{
											  			$(this).removeClass("value");
											  			$(this).removeClass("value_false");
											  			$(this).removeClass("value_Null");
											  			$(this).attr("valid", "true");
											  		 	$(this).addClass("value_true");
											  		}
                                                }

                                                if($(this).attr("type") == "checkbox")
                                                	{   //проверяем включен ли чекбокс
                                                		$(this).attr("valid", $(this).attr("checked"));
                                                	}
                                                if($(this).attr("type") == "radio")
                                                	{   //проверяем включена ли радиокнопка
                                                		$(this).attr("valid", $(this).attr("checked"));
                                                	}

                                                     // submit активна / не активна
											  		 $(""+settings.validation_form+" "+settings.submit+"").attr("disabled", submit_on_off());
											  } );
				  });//$("."+validation_form+" ."+text+"").each(
          //Переносим фокус на выбранный элемент
        $(""+settings.validation_form+" "+settings.focus+"").focus();

         //добавляем * к обязательным полям
		$(""+settings.validation_form+" "+settings.important+"").before("<strong class='important_marker'>"+settings.important_marker+"</strong>");
		if ( $(this).hasClass("important") )
				  			{
				  				$(this).addClass("value_false");
				  			}



//==========================================
//функция проверки email'a
function valid_email(val)
{
	var reg=/^[a-z0-9\._-]+@+[a-z0-9\._-]+\.+[a-z]{2,3}/ ;
	var result=reg.test(val);
	return result;
}

//функция проверки паролей на совпадение
function pass_ravno()
{
	if( $(""+settings.validation_form+" "+settings.password2+"").attr("value") == $(""+settings.validation_form+" "+settings.password1+"").attr("value") )
	{
		$(""+settings.validation_form+" "+settings.password2+"").next().html("<div class='valid_message'>"+settings.pass_valid_message+"</div>");

		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value");
		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value_Null");
		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value_false");
		$(""+settings.validation_form+" "+settings.password2+"").addClass("value_true");
		$(""+settings.validation_form+" "+settings.password2+"").attr("valid", "true");

	}
	else{

		$(""+settings.validation_form+" "+settings.password2+"").next().html("<div class='invalid_message'>"+settings.pass_error_message+"</div>");

		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value");
		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value_Null");
		$(""+settings.validation_form+" "+settings.password2+"").removeClass("value_false");
		$(""+settings.validation_form+" "+settings.password2+"").addClass("value_false");
		$(""+settings.validation_form+" "+settings.password2+"").attr("valid", "false");
	}
 return false;
}


//функция вкл.выкл submit
function submit_on_off()
{
	var validEND=0;
		$(""+settings.validation_form+" "+settings.important+"").each(
		function()
		{
				if ( $(this).attr("valid") == "false" )
				{
					 validEND=1;

				}
                return 	validEND;
		});
		return 	validEND;
}


//===============================================
}

