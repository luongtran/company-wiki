//= require jquery.jstree

$(document).ready(function () {

    var trees = $(".treeViewDiv");
    for (var i = 0; i < trees.length; i++) {
        var current_node_pid = $(trees[i]).attr('pid');
        
        treeIt(i);
    }
    function treeIt(i) {
        var current_node_pid = $(trees[i]).attr('pid');
        
        $($(".treeViewDiv")[i]).jstree({
            "json_data": {
                "ajax": {
                    "url": function (node) {
                        if (node == -1) {
                            console.log('current:' + current_node_pid);
                            return "/roots/" + current_node_pid;
                        } else { // Node have parent
                        	var parent_pid = $(node).attr('pid');
                        	console.log('parent:' + parent_pid);
                            return "/childrens-of/" + parent_pid;
                        }
                    },
                    "type": "GET",
                    "success": function (nodes) {
                        console.log(nodes.length);
                        var data = [];
                        for (var i = 0; i < nodes.length; i++) {
                            var op = nodes[i];
                            
                            var node = {
                                "data": op.title,
                                "attr": {"pid": op.id, "parent":op.parent, "class": "child", "data-sortable-type" : "child"},
                                "metadata": op,
                                "state": "closed"
                            }
                            data.push(node);
                        }
                        console.log(data);
                        return data;
                    }
                },
            },
            "themes": {
                "theme": "classic",
                "dots": true,
                "icons": false
            },
            "plugins": [ "themes", "json_data", "ui" ]   //add "dnd" to Drag & Drop
        }).bind("select_node.jstree", function (e, data) {
                var pid = $(data.rslt.obj[0]).attr('pid');
                $.ajax({
                    url: "/subject-infor/" + pid,
                    type: 'GET',
                    success: function () {
                        console.log('success');
                    }
                })
           });
    };
    $("#sortable").sortable({
    	items: '> div',
        update: function (event, ui) {
            var order = [];
            for (i = 0; i < $(".treeViewDiv").length; i++) {
                order[i] = $($(".treeViewDiv")[i]).attr('pid');
            }
            console.log(order);
            var datasend = new FormData();
            datasend.append('new_order', order)
            $.ajax({
                url: '/reorder/',
                data: datasend,
                contentType: false,
                processData: false,
                type: 'POST',
                success: function (respond) {
                }
            })
        }
    });
    
    $(".children").sortable({
    	items: '> li',
    	update:function(e, ui) {
    		var order = [];
    		for(i = 0; i < $(".child").length; i++) {
    			order[i] = $($(".child")[i]).attr('pid');
    		}
    		var parent = $($(".child")[i]).attr('parent');
    		console.log(order);
    		var datasend = new FormData();
    		datasend.append('new_order', order);
    		datasend.append('parent', parent);
    		$.ajax({
    			url: '/reorder',
    			data:datasend,
    			contentType: false,
                processData: false,
                type: 'POST',
                success:function(respond) {
                	
                }
    		});
    	}
    });
});