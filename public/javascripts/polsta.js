function clearCheckboxes(ids) {
	for (var i=0; i<ids.length; ++i) {
		var id = ids[i]
		var el = document.getElementById(id)
		if (el)
			el.checked = false;
	}
}



Position.getWindowSize = function(w) {
  var array = [];

  w = w ? w : window;
  array.width = array[0] = w.innerWidth || (w.document.documentElement.clientWidth || w.document.body.clientWidth);
  array.height = array[1] = w.innerHeight || (w.document.documentElement.clientHeight || w.document.body.clientHeight);

  return array;
}



Position.center = function(element) {
	var options = Object.extend(
		{zIndex: 999, update: false}, 
		arguments[1] || {}
	);
	element = $(element)
	if(!element._centered){
		Element.setStyle(element, {position: 'absolute', zIndex:options.zIndex });
		element._centered = true;
	}
	var dims = Element.getDimensions(element);
	Position.prepare();
	var winWidth = self.innerWidth ||
	document.documentElement.clientWidth || document.body.clientWidth || 0;
	var winHeight = self.innerHeight || document.documentElement.clientHeight || document.body.clientHeight || 0;
	var offLeft = (Position.deltaX + Math.floor((winWidth-dims.width)/2));
	var offTop = (Position.deltaY + Math.floor((winHeight-dims.height)/2));
	element.style.top = ((offTop != null && offTop > 0) ? offTop : '0') + 'px';
	element.style.left = ((offLeft != null && offLeft > 0) ? offLeft : '0') + 'px';
	if(options.update) {
		Event.observe(
			window, 
			'resize', 
			function(evt) {
				Position.center(element);
			}, 
			false
		);
		Event.observe(window, 'scroll', function(evt){
			Position.center(element);
			}, false
		);
	}
}


function centerAndStretch(id) {
  var el = $(id);
  win = Position.getWindowSize();
  el.style.width = win.width + "px";
  el.style.height = win.height + "px";
  centerElement($(id));

}

function centerElement(id) {
	Position.center(id);
}

function busy() {
	Position.center('working');
	$('working').style.display = '';
}

function idle() {
	new Effect.Fade("working",{duration:0.5});
}

Addables = Class.create();
Addables.prototype = {

	initialize:function(id) {
	
		var addables = this;
		Addables.visibleDescription = $("addables_intro");
		Addables.activeLink = $("addables_intro");

		$$("#addables a").each(function(link, index) {
			div = $("description" + index);
			div.link = link
			Event.observe(link, "mouseover", addables.show.bindAsEventListener(div), link);
			//Event.observe(link, "mouseout", addables.hide.bindAsEventListener(div));
		});

	},
	
	show:function(e, link) {
		this.link.addClassName("hover");
		if (Addables.visibleDescription && Addables.visibleDescription != this) {
			Addables.visibleDescription.hide();
			Addables.activeLink.removeClassName("hover");
		}
		$(this.id).show();
		Addables.visibleDescription = this;
		Addables.activeLink = this.link;
		
	},
	
	hide:function(e) {
		$(this.id).hide();
	}

};

RowHighlightingTable = Class.create();
RowHighlightingTable.prototype = {
	initialize: function(id) {
		table = this;
		this.table = $(id);
		for (i=0; i<this.table.rows.length; ++i) {
			row = this.table.rows[i]
			Event.observe(row, "mouseover", table.over.bindAsEventListener(this,row), row);
			Event.observe(row, "mouseout", table.out.bindAsEventListener(this,row), row);
			Event.observe(row, "click", table.click.bindAsEventListener(this,row), row);

		}

	},
	over: function(e, row) {
		row.addClassName("hilite")
	},
	out: function(e, row) {
		row.removeClassName("hilite")
	},
	click: function(e, row) {
		row.getElementsBySelector("a").each(function(link, index) {
			document.location = link.href;
		});
	}

	
}
