function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

$(document).ready(function () {
    $("#searchInput1").keyup(function () {
        //split the current value of searchInput
        var data = this.value.split(" ");
        //create a jquery object of the rows
        var jo = $("[id$=grdMSATask]").find("tr");

        var header = $(jo).first("tr");

        if (this.value == "") {
            jo.show();
            return;
        }
        //hide all the rows
        jo.hide();

        //Recusively filter the jquery object to get results.
        var filterResult = jo.filter(function (i, v) {
            var $t = $(this);
            for (var d = 0; d < data.length; ++d) {
                var str = $t.html().toLowerCase();
                if (str.toLowerCase().indexOf(data[d].toLowerCase()) >= 0) {
                    return true;
                }
            }
            return false;
        });

        //show the rows that match.
        header.add(filterResult).show();
    }).focus(function () {
        this.value = "";
        $(this).css({
            "color": "black"
        });
        $(this).unbind('focus');
    }).css({
        "color": "#C0C0C0"
    });

    $("#searchInput2").keyup(function () {
        //split the current value of searchInput
        var data = this.value.split(" ");
        //create a jquery object of the rows
        var jo = $("[id$=grdMSARecommendationTask]").find("tr");

        var header = $(jo).first("tr");

        if (this.value == "") {
            jo.show();
            return;
        }
        //hide all the rows
        jo.hide();

        //Recusively filter the jquery object to get results.
        var filterResult = jo.filter(function (i, v) {
            var $t = $(this);
            for (var d = 0; d < data.length; ++d) {
                var str = $t.html().toLowerCase();
                if (str.toLowerCase().indexOf(data[d].toLowerCase()) >= 0) {
                    return true;
                }
            }
            return false;
        });

        //show the rows that match.
        header.add(filterResult).show();
    }).focus(function () {
        this.value = "";
        $(this).css({
            "color": "black"
        });
        $(this).unbind('focus');
    }).css({
        "color": "#C0C0C0"
    });

    $('.panel-collapse').collapse('show');


    var status = getParameterByName('Status');

    if (typeof status != 'undefined' && status != "" && status != null)
    {
        switch (status) {
            case "MSA_1":
                alert('MSA Submitted...');
                break;
            case "MSA_2":
                alert('MSA Saved As Draft...');
                break;
            case "MSAR_1":
                alert('Recommendation Saved...');
                break;
            case "MSAR_2":
                alert('Recommendation Sent...');
                break;
            case "MSAR_3":
                alert('Recommendation Approved...');
                break;
            case "MSAR_4":
                alert('Recommendation Rejected...');
                break;

            default:
                break;
        }
    }
});