var WikiLingoFLPView = (function() {
	var Construct = function(el, partialWikiMetadata) {
		this.busy = false;
		this.partialWikiMetadata = partialWikiMetadata;
		this.box = null;

		var _this = this,
			createButton = $('<div>' + tr( 'Create PastLink & FutureLink' ) + '</div>')
			.button()
			.css('position', 'fixed')
			.css('left', '5px')
			.css('top', '5px')
			.fadeTo(0, 0.6)
			.hover(function(){
				createButton.addClass('ui-state-highlight');
			}, function() {
				createButton.removeClass('ui-state-highlight');
			})
			.appendTo('body')
			.click(function() {

				//hide the link
				createButton.hide();

				//let the end user know what to do
				$.notify(tr('Highlight some text within the wiki page to create your links'));

				//
				$(document).bind('mousedown', function() {
					if (_this.busy) return;
					$('div.pastlinkCreate').remove();
					$('embed[id*="ZeroClipboard"]').parent().remove();
				});

				el.rangy(function(o) {
					if (_this.busy) return;
					var text = $.trim(o.text);

					_this.pastlinkCreate = $('<div>' + tr('Accept PastLink') + '</div>')
						.button()
						.addClass('pastlinkCreate')
						.css('position', 'absolute')
						.css('top', o.y + 'px')
						.css('left', o.x + 'px')
						.css('font-size', '10px')
						.fadeTo(0,0.80)
						.mousedown(function() {
							var suggestion = $.trim(rangy.expandPhrase(text, '\\n', el[0])),
								buttons = {};

							if (suggestion == text) {
								_this.getAnswers();
							} else {
								buttons[tr('Ok')] = function() {
									text = suggestion;
									_this.box.dialog('close');
									_this.getAnswers();
								};

								buttons[tr('Cancel')] = function() {
									_this.box.dialog('close');
									_this.getAnswers();
								};

								_this.box = $('<div>\
	<table>\
		<tr>\
			<td>' + tr('You selected:') + '</td>\
			<td><b>"</b>' + text + '<b>"</b></td>\
		</tr>\
		<tr>\
			<td>' + tr('Suggested selection:') + '</td>\
			<td class="ui-state-highlight"><b>"</b>' + suggestion + '<b>"</b></td>\
		</tr>\
	</tabl>\
</div>'
									)
									.dialog({
										title: tr("Suggestion"),
										buttons: buttons,
										width: $(window).width() / 2,
										modal: true
									})
								}
						})
						.appendTo('body');
					});
				});

		Construct.prototype = {
			encode: function (s){
				for(var c, i = -1, l = (s = s.split("")).length, o = String.fromCharCode; ++i < l;
				    s[i] = (c = s[i].charCodeAt(0)) >= 127 ? o(0xc0 | (c >>> 6)) + o(0x80 | (c & 0x3f)) : s[i]
				){}
				return s.join("");
			},
			makeClipboardData: function(metadata) {
				var _this = this;
				metadata.text = this.encode((o.text + '').replace(/\\n/g, ''));

				metadata.hash = md5(
					rangy.superSanitize(
						metadata.author +
						metadata.authorInstitution +
						metadata.authorProfession
					)
					,
					rangy.superSanitize(metadata.text)
				);

				this.busy = true;

				var pastlinkCopy = $('<div></div>');
				var pastlinkCopyButton = $('<div>' + tr('Click HERE to Copy to Clipboard') + '</div>')
					.button()
					.appendTo(pastlinkCopy);
				var pastlinkCopyValue = $('<textarea style="width: 100%; height: 80%;"></textarea>')
					.val(encodeURI(JSON.stringify(metadata)))
					.appendTo(pastlinkCopy);

				pastlinkCopy.dialog({
					title: tr("Copy text and Metadata"),
					modal: true,
					close: function() {
						_this.busy = false;
						$(document).mousedown();
					},
					draggable: false
				});

				pastlinkCopyValue.select().focus();

				var clip = new ZeroClipboard.Client();
				clip.setHandCursor( true );

				clip.addEventListener('complete', function(client, text) {
					_this.pastlinkCreate.remove();
					pastlinkCopy.dialog( "close" );
					clip.hide();
					_this.busy = false;


					$.notify(tr('Text and Metadata copied to Clipboard'));
					return false;
				});

				clip.glue( pastlinkCopyButton[0] );

				clip.setText(pastlinkCopyValue.val());

				$('embed[id*="ZeroClipboard"]').parent().css('z-index', '9999999999');
			},
			getAnswers: function() {
				var _this = this;
				if (!this.answers.length) {
					return this.acceptPhrase(partialWikiMetadata);
				}

				var answersDialog = $('<table width="100%;" />');

				$.each(this.answers, function() {
					var tr = $('<tr />').appendTo(answersDialog);
					$('<td style="font-weight: bold; text-align: left;" />')
						.text(this.question)
						.appendTo(tr);

					$('<td style="text-align: right;"><input class="answerValues" style="width: inherit;"/></td>')
						.appendTo(tr);
				});

				var answersDialogButtons = {};
				answersDialogButtons[tr("Ok")] = function() {
					$.each(_this.answers, function(i) {
						_this.answers[i].answer = escape(answersDialog.find('.answerValues').eq(i).val());
					});

					answersDialog.dialog('close');

					_this.acceptPhrase();
				};

				answersDialog.dialog({
					title: tr("Please fill in the questions below"),
					buttons: answersDialogButtons,
					modal: true,
					width: $(window).width() / 2
				});
				return true;
			},

			//var timestamp = '';

			acceptPhrase: function(metadata) {
				/* Will integrate when timestamping works
				 $.modal(tr("Please wait while we process your request..."));
				 $.getJSON("tiki-index.php", {
				 action: "timestamp",
				 hash: hash,
				 page: '$page'
				 }, function(json) {
				 timestamp = json;
				 $.modal();
				 makeClipboardData();
				 });
				 */
				this.makeClipboardData(metadata);
			}
		}
	};
	return Construct;
})();