<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<fieldset>
    <h1>Hello, test of the Magic 8 Ball</h1>
    <%--<c:url value="${url.base}${fn:replace(renderContext.mainResource.path, '.html', '.randomAnswerAction.do')}" var="myUrl"/>--%>
    <c:url value="${url.base}${fn:replace(renderContext.mainResource.path, '.default.html', '.randomAnswerAction.do')}" var="myUrl"/>

    <h1>Enter your question, i will give you my honest answer, indeed press Enter to finish.</h1>
    <input id="inputText" type="text"/>

    <div id="result"></div>


</fieldset>
<script type="text/javascript">
    <%--function myFunction() {--%>
    <%--$.ajax({--%>
    <%--method: 'POST',--%>
    <%--dataType: "json",--%>
    <%--url: '${myUrl}'--%>
    <%--})--%>
    <%--.success(function (response) {--%>
    <%--console.log(response);--%>
    <%--});--%>
    <%--}--%>


    function EmptyInput() {
        var x = document.getElementById("inputText");
        x.value = "";
    }
    function load(divResult, textForResult, tempVal, countAsk) {
        var xhr = new XMLHttpRequest();


        xhr.open('POST', '${myUrl}', true);

        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.setRequestHeader("Accept", "application/json");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                console.log(this + "this log");
                console.log('cool');
                var result = JSON.parse(xhr.responseText);

                console.log("  For the result debug       " + result['key'] + " el result en front");


                if (textForResult.getAttribute("id") != "resultText" + countAsk) {
                    textForResult = document.createElement('H2');
                    textForResult.setAttribute("id", "resultText" + countAsk);

                }
                textForResult.appendChild(document.createTextNode(tempVal +
                    ":  " + result['key']));
                divResult.appendChild(textForResult);


            }


        };

        xhr.send('nodeIdentifier=${currentNode.identifier}');

    }
    /*


     */


    (function () {

        //var mylink = document.getElementById('button1');
        //  var test = document.querySelector("#resultText");

        var divResult = document.getElementById('result'),
            inputText = document.getElementById('inputText'),
            //   button = document.getElementById('button1'),
            tempVal = "",
            countAsk = 0,
            textForResult;
        countAsk++;

        if (document.getElementById('resultText') === null) {
            textForResult = document.createElement('H2');
            console.log(textForResult.getAttribute("id") + "    balbal");


        }


        /*  button.addEventListener('click', function () {
         load(divResult, textForResult);


         });

         */
        inputText.onkeypress = function (e) {
            if (!e) e = window.event;
            var keyCode = e.keyCode || e.which;
            if (keyCode == '13') {
                tempVal = this.value;


                load(divResult, textForResult, tempVal, countAsk);
                EmptyInput();


            }

        }


    })();


</script>
