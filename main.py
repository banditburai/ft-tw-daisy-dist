# ============================================================================
#  FastHTML + TailwindCSS + DaisyUI Template
# ============================================================================
from fasthtml.common import *

styles = Link(rel="stylesheet", href="/styles/output.css", type="text/css")

app, rt = fast_app(
    pico=False,
    surreal=False,
    live=True,
    hdrs=(styles,),
    htmlkw=dict(lang="en", dir="ltr", data_theme="dark"),
    bodykw=dict(cls="min-h-screen bg-base-100")
)

@rt("/")
def get():
    return Div(
        Div(
            H1("Nothing to see here yet...", 
               cls="text-2xl font-bold mb-2"),
            P("But your FastHTML app is running!", 
              cls="text-base text-base-content/60"),
            cls="text-center"
        ),
        cls="min-h-screen flex items-center justify-center"
    )

if __name__ == "__main__":
    serve()