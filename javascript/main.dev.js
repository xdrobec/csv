/**
 * Hlavný javascript súbor, developer nekompresovaná verzia
 *
 * @author Matus Macak < matusmacak@justm.sk > 
 * @link http://www.justm.sk/
 * @version 1.0 Nubium
 * @since Subor je súčasťou aplikácie od verzie 1.0
 * @package javascript
 * 
 */

/**
 * @var boolean fSubmitInProgress Definuje či bol formulár potvrdený a čaká sa na jeho
 * spracovanie alebo nie
 */
var fSubmitInProgress = false;

//Potrvrdenie formulárov ajaxom
$(document).on( "submit", ".ajaxForm", function(event){
    
    event.preventDefault();
            
    if( !window["fSubmitInProgress"] ) {
        window["fSubmitInProgress"] = true;
        try{
            $(this).find(".ajaxForm-submit .loader").show();
            $(this).find(".ajaxForm-submit input[type=submit]").addClass("disabled");
            
            var $thisForm = $(this);
            var data = $thisForm.serializeArray();  
            var myData = {};
            
            for (var i = 0; i < data.length; i++) {
                var splitted = data[i].name.split("[");
                var model = splitted.shift();
                if( splitted[0] ){
                    var name = splitted[0].split("]").shift();
                    
                    if( myData.hasOwnProperty(model) ){
                        myData[model][name] = data[i].value;
                    }else{
                        myData[model] = {};
                        myData[model][name] = data[i].value;
                    }
                }else{
                    myData[model] = data[i].value;
                }
            }
        }catch(e) { }
        
        ajaxLoad( "POST", $thisForm.attr("action"), myData, $thisForm );
    }
});

/**
 * AJAX LOAD 
 * 
 * @param {String} $method Method to use
 * @param {String} $url Request URL
 * @param {Object} $data Data to send
 * @param {Object} $fireObject Object that fires initial event
 * @returns {void} Triggers new event
 */
function ajaxLoad( $method, $url, $data, $fireObject ){
    
    if ( !($data instanceof Array) ) {
        $data = {}
    } 
    $data["ajaxLoad"] = 1;
    
    $.ajax({
        type: $method,
        url: $url,
        data: $data,
        success: function( data, status ){
            window["fSubmitInProgress"] = false;
            //Triggers new event and passes recievedData for a next processing
            $fireObject.trigger({type: "ajaxSuccess", recData: data});
        },
        error: function(){
            alert("Ospravedlňujeme sa, Vašu požiadavku sa nepodarilo vykonať.");
            window["fSubmitInProgress"] = false;
        }        
    });
}

/**
 * Finish ajaxForm handling
 */
$(document).on( "ajaxSuccess", ".ajaxForm", function(event){
    //TODO display recieved data from event.data
    
});

/* SEARCH ROW */

/**
 * @var int searchRequestID - číslo ktoré prislúcha najnovšej požiadavke. 
 * Nastavuje sa pred volaním AJAX vyhľadávania a všetky odpovede s nižším ID sú 
 * sú zahodené aby nedošlo k prepísaniu nových výsledkov
 */
var searchRequestID = 0;

/**
 * @var boolean searchRespClosed Definueje, či je okno s výsledkami zatvorené, 
 * ak áno neprebiehajú pokusy o jeho zatvorenie
 */
var searchRespClosed = true;
//Funkcia zobrazí element do ktorého sú vložené výsledky AJAX vyhľadávania
function getResponse($element){
    
    if( $element.val() !== "" ){
        var keyword = $element.val();
        $("div#searchResp").slideDown();
        window['searchRespClosed'] = false;
        if(keyword.length > 2){
            window["searchRequestID"] = window["searchRequestID"]++;
            var thisRequestID = window["searchRequestID"];
            $.ajax({
                type: "GET",
                url: $element.parents("form").attr("action"),
                data: {fulltext_search: $element.val(), ajaxSearch: true},
                success: function(data, status){
                    if( thisRequestID !== window["searchRequestID"] ){
                        return false;
                    }
                    else{
                        $("div#searchResp").html(data);
                    }
                },
                error: function(){
                    $("div#searchResp").html("<i>Pri vyhľadávaní nastala chyba</i>");
                }
            });
        }
    }
    else if(!window['searchRespClosed']){
        window['searchRespClosed'] = true;
        $("div#searchResp").delay(200).slideUp();
        $("div#searchResp").delay(700).queue(function(){
            $(this).html("");
            $(this).append("<div class=\"preloader\"></div>");
            $(this).dequeue();
        });
    }
}
var counter = 0;
////Pohyb nadol medzi výsledkami vyhľadávania
function movInResListDown(){
    $sElem = $("div#searchResp").find("a.selected");
    if( $sElem.length === 0 ) {
        $newElem = $("div#searchResp").find("a:first-child").addClass("selected");
    }else{
        $newElem = $sElem.removeClass("selected").next().addClass("selected");
    }
    $("form#mhsr input[type=text]").val($newElem.find("strong").html());
}

////Pohyb nahor medzi výsledkami vyhľadávania
function movInResListUp(){
    $sElem = $("div#searchResp").find("a.selected");
    if( $sElem.length === 0 ) {
        $newElem = $("div#searchResp").find("a:last-child").addClass("selected");
    }else{
        $newElem = $sElem.removeClass("selected").prev().addClass("selected");
    }
    $("form#mhsr input[type=text]").val($newElem.find("strong").html());
}

