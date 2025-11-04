// alert_boxed_message color options
#define DEFAULT "default"
#define BLUE "blue"
#define GREEN "green"
#define GREY "grey"
#define ORANGE "orange"
#define PINK "pink"
#define PURPLE "purple"
#define RED "red"
#define YELLOW "yellow"
#define alert_boxed_message(color, str) ("<div class='chat_alert_[color ? "[color]" : "default"]'>" + str + "</div>")

// chat spans
#define span_yellow(str) ("<span class='yellow'>" + str + "</span>")
#define span_cyan(str) ("<span class='cyan'>" + str + "</span>")
#define span_white(str) ("<span class='white'>" + str + "</span>")
#define span_pink(str) ("<span class='pink'>" + str + "</span>")
#define span_rlooc(str) ("<span class='rlooc'>" + str + "</span>")
