define input  parameter c-widget-name  as char   no-undo.
define input  parameter c-widget-type  as char   no-undo.
define input  parameter h-start-widget as WIDGET-HANDLE no-undo.
define output parameter h-widget       as handle no-undo.

RUN pi-findwidget (INPUT c-widget-name, INPUT c-widget-type, INPUT h-start-widget, OUTPUT h-widget).

PROCEDURE pi-findwidget:
    define input  parameter c-widget-name  as char   no-undo.
    define input  parameter c-widget-type  as char   no-undo.
    define input  parameter h-start-widget as WIDGET-HANDLE no-undo.
    define output parameter h-widget       as handle no-undo.
    DEFINE VARIABLE cName AS CHAR NO-UNDO.

    do while valid-handle(h-start-widget):
        IF (h-start-widget:TYPE = "FILL-IN" or h-start-widget:TYPE = "EDITOR" or h-start-widget:TYPE = "TOGGLE-BOX" or h-start-widget:type = "COMBO-BOX") AND h-start-widget:TABLE <> ? THEN
            ASSIGN cName = h-start-widget:TABLE + "." + h-start-widget:NAME.
        ELSE
            ASSIGN cName = h-start-widget:NAME.
        IF c-widget-type <> ? and c-widget-type <> "" and (c-widget-type = "TEXT" OR c-widget-type = "LITERAL") THEN DO:
            IF h-start-widget:type = c-widget-type THEN DO:
                IF (h-start-widget:name <> ? and h-start-widget:name = c-widget-name) OR h-start-widget:screen-value = c-widget-name THEN DO:
                    assign h-widget = h-start-widget:handle.
                    leave.
                END.

            END.
        END.
        if cName = c-widget-name and
           (c-widget-type = ? OR c-widget-type = "" OR h-start-widget:type = c-widget-type) then do:
            assign h-widget = h-start-widget:handle.
            leave.
        end.
    
        if h-start-widget:type = "field-group":u or
           h-start-widget:type = "frame":u or
           h-start-widget:type = "dialog-box":u then do:
            run pi-findwidget (input  c-widget-name,
                               input  c-widget-type,
                               input  h-start-widget:first-child,
                               output h-widget).
    
            if valid-handle(h-widget) then
                leave.
        end.

        assign h-start-widget = h-start-widget:next-sibling.
    end.
END.
