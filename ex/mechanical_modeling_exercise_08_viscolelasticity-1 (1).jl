### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 4fc88de5-456f-4ca3-8836-998628d09770
begin
	using Ferrite
	using FerriteGmsh
	using FerriteViz
	using Tensors
	using LinearAlgebra
	using SparseArrays
	using StringDistances
	using Luxor
	import CairoMakie
end

# ╔═╡ 6065849d-042a-4c75-b663-a86052f31d3c
begin 
	using PlutoUI
	TableOfContents(title="Exercise 8")
end

# ╔═╡ 2d0debb7-7d67-43e1-aba8-85fcae635c0f
md"""
# Mechanical Modeling of Materials – Exercise 8
Today, we are going to dive deeper into Rheology. In the lecture, we looked at two simple models: the Kelvin-Voigt model and the Maxwell model which both contained two elements, a spring and a damper.
"""

# ╔═╡ 0ec3a66f-f612-4264-9670-0ca974103902
md"""
## Part 1 – A quick revision of the basic elements of Rheology

Many materials can be modeled using rheological elements, if they are described one dimensionally.
By combining the three basic elements –  a 'Hooke's Spring', a 'Newton's Damper' and a 'St Venant's Frictional Element' – one can model virtually infinitely many material behaviours. Let us first of all recall the basic behaviour of each of these models
"""

# ╔═╡ 72ca782e-85b6-4d99-b1f8-35963aac0ccd
theorie1 = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   id="svg3368"
   xml:space="preserve"
   width="100%"
   height="566.51459"
   viewBox="0 0 577.51947 566.51456"
   sodipodi:docname="theorie1.svg"
   inkscape:version="1.0.2 (e86c870879, 2021-01-15)"><metadata
     id="metadata3374"><rdf:RDF><cc:Work
         rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
     id="defs3372"><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3434"><path
         d="m 1077.6,6205.8 v -320 h 1010 v 320 z m 933.06,-256.04 h 76.22 v 28.34 h -76.22 v 0 l 56.69,-14.49 z"
         clip-rule="evenodd"
         id="path3432" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3444"><path
         d="m 1077.6,6205.8 v -320 h 1010 v 320 z"
         id="path3442" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3458"><path
         d="m 1077.6,6205.8 v -320 h 1010 v 320 z"
         id="path3456" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3464"><path
         d="m 1077.6,6205.8 v -320 h 1010 v 320 z m 74.5,-227.7 h -76.21 v -28.34 h 76.21 v 0 l -56.69,13.85 z"
         clip-rule="evenodd"
         id="path3462" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3474"><path
         d="m 1077.6,6205.8 v -320 h 1010 v 320 z"
         id="path3472" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3494"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z m 169.61,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.89,75.59 z"
         clip-rule="evenodd"
         id="path3492" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3504"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z"
         id="path3502" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3524"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z m 1303.43,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.89,75.59 z"
         clip-rule="evenodd"
         id="path3522" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3534"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z"
         id="path3532" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3546"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z m 2049.23,-893.38 h 95.12 v 37.8 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path3544" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3556"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z"
         id="path3554" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3568"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z m 915.41,-893.38 h 95.12 v 37.8 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path3566" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3578"><path
         d="M 2551.2,6293 V 5233 h 2150 v 1060 z"
         id="path3576" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3698"><path
         d="m 1077.6,4751.4 v -320 h 1010 v 320 z m 933.06,-256.04 h 76.22 v 28.34 h -76.22 v 0 l 56.69,-14.49 z"
         clip-rule="evenodd"
         id="path3696" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3708"><path
         d="m 1077.6,4751.4 v -320 h 1010 v 320 z"
         id="path3706" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3720"><path
         d="m 1077.6,4751.4 v -320 h 1010 v 320 z"
         id="path3718" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3726"><path
         d="m 1077.6,4751.4 v -320 h 1010 v 320 z m 74.5,-227.7 h -76.21 v -28.34 h 76.21 v 0 l -56.69,13.85 z"
         clip-rule="evenodd"
         id="path3724" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3736"><path
         d="m 1077.6,4751.4 v -320 h 1010 v 320 z"
         id="path3734" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3764"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z"
         id="path3762" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3776"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z m 915.41,-893.37 h 95.12 v 37.79 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path3774" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3786"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z"
         id="path3784" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3798"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z m 1303.43,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.89,75.59 z"
         clip-rule="evenodd"
         id="path3796" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3808"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z"
         id="path3806" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3820"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z m 2049.23,-893.37 h 95.12 v 37.79 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path3818" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3830"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z"
         id="path3828" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3844"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z m 169.61,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.89,75.59 z"
         clip-rule="evenodd"
         id="path3842" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3854"><path
         d="m 2551.2,4783.4 v -1060 h 2150 v 1060 z"
         id="path3852" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4032"><path
         d="m 1077.6,3277 v -300 h 1030 v 300 z"
         id="path4030" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4038"><path
         d="m 1077.6,3277 v -300 h 1030 v 300 z m 74.5,-264.04 h -76.21 v -28.35 h 76.21 v 0 l -56.69,13.86 z"
         clip-rule="evenodd"
         id="path4036" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4048"><path
         d="m 1077.6,3277 v -300 h 1030 v 300 z"
         id="path4046" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4064"><path
         d="m 1077.6,3277 v -300 h 1030 v 300 z m 947.54,-207.35 h 76.22 v 28.34 h -76.22 v 0 l 56.7,-14.48 z"
         clip-rule="evenodd"
         id="path4062" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4074"><path
         d="m 1077.6,3277 v -300 h 1030 v 300 z"
         id="path4072" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4102"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4100" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4122"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z m 226.61,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.89,75.59 z"
         clip-rule="evenodd"
         id="path4120" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4132"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4130" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4144"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z m 972.41,-893.37 h 95.12 v 37.79 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path4142" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4154"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4152" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4166"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z m 1360.43,-109.78 v 95.12 h -37.79 v -95.12 0 l 18.9,75.59 z"
         clip-rule="evenodd"
         id="path4164" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4176"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4174" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4188"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4186" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4194"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z m 2106.23,-893.37 h 95.12 v 37.79 h -95.12 v 0 l 75.59,-18.9 z"
         clip-rule="evenodd"
         id="path4192" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4204"><path
         d="m 2976,3243.8 v -1060 h 2200 v 1060 z"
         id="path4202" /></clipPath></defs><sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1900"
     inkscape:window-height="1033"
     id="namedview3370"
     showgrid="false"
     inkscape:zoom="0.6376649"
     inkscape:cx="298.49358"
     inkscape:cy="234.91953"
     inkscape:window-x="1929"
     inkscape:window-y="36"
     inkscape:window-maximized="0"
     inkscape:current-layer="g4264" /><g
     id="g3376"
     inkscape:groupmode="layer"
     inkscape:label="01_uebung_materialmodellierung_2018"
     transform="matrix(1.3333333,0,0,-1.3333333,-114.25279,861.04805)"><g
       id="g3378"
       transform="scale(0.1)"><g
         id="g3402"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,85.0801,636.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFBX1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3422">Hooke spring element</text><text
           transform="matrix(1,0,0,-1,246.1201,636.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3426">linear elastic behavior</text></g><g
         id="g3428"><g
           id="g3430"
           clip-path="url(#clipPath3434)"><path
             d="m 1900.43,5963.61 h 177"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3436" /></g></g><g
         id="g3438"><g
           id="g3440"
           clip-path="url(#clipPath3444)"><path
             d="m 2010.66,5949.76 56.69,13.85 -56.69,14.49 v -28.34"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3446" /><path
             d="m 2010.66,5949.76 56.69,13.85 -56.69,14.49 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3448" /><path
             d="m 1333.52,5963.61 h 71.17 l 17.64,71.18 35.28,-141.72 35.27,141.72 35.27,-141.72 35.91,141.72 35.27,-141.72 35.28,141.72 35.27,-141.72 35.91,141.72 35.27,-141.72 17.64,70.54 h 71.18"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3450" /></g></g><g
         id="g3452"><g
           id="g3454"
           clip-path="url(#clipPath3458)"><g
             id="g3460"
             clip-path="url(#clipPath3464)"><path
               d="M 1262.96,5963.61 H 1085.33"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path3466" /></g></g></g><g
         id="g3468"><g
           id="g3470"
           clip-path="url(#clipPath3474)"><path
             d="m 1152.1,5978.1 -56.69,-14.49 56.69,-13.85 v 28.34"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3476" /><path
             d="m 1152.1,5978.1 -56.69,-14.49 56.69,-13.85 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3478" /></g></g><g
         id="g3480"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,154.56,610.54)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3486"><tspan
             x="0"
             y="0"
             id="tspan3482">E</tspan><tspan
             x="39.719898 -36.840302"
             y="8.5203104"
             sodipodi:role="line"
             id="tspan3484">σσ</tspan></text></g><g
         id="g3488"><g
           id="g3490"
           clip-path="url(#clipPath3494)"><path
             d="M 2701.91,6268.89 V 5418.52"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3496" /></g></g><g
         id="g3498"><g
           id="g3500"
           clip-path="url(#clipPath3504)"><path
             d="m 2720.81,6183.22 -18.9,75.59 -18.89,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3506" /><path
             d="m 2720.81,6183.22 -18.9,75.59 -18.89,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3508" /><path
             d="m 2673.57,5985.43 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3510" /><path
             d="m 3807.39,5985.43 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3512" /><path
             d="m 3183.79,5446.87 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3514" /><path
             d="m 4317.61,5446.87 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3516" /></g></g><g
         id="g3518"><g
           id="g3520"
           clip-path="url(#clipPath3524)"><path
             d="M 3835.73,6268.89 V 5418.52"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3526" /></g></g><g
         id="g3528"><g
           id="g3530"
           clip-path="url(#clipPath3534)"><path
             d="m 3854.63,6183.22 -18.9,75.59 -18.89,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3536" /><path
             d="m 3854.63,6183.22 -18.9,75.59 -18.89,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3538" /></g></g><g
         id="g3540"><g
           id="g3542"
           clip-path="url(#clipPath3546)"><path
             d="m 3750.7,5418.52 h 935.4"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3548" /></g></g><g
         id="g3550"><g
           id="g3552"
           clip-path="url(#clipPath3556)"><path
             d="m 4600.43,5399.62 75.59,18.9 -75.59,18.9 v -37.8"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3558" /><path
             d="m 4600.43,5399.62 75.59,18.9 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3560" /></g></g><g
         id="g3562"><g
           id="g3564"
           clip-path="url(#clipPath3568)"><path
             d="m 2616.88,5418.52 h 935.4"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3570" /></g></g><g
         id="g3572"><g
           id="g3574"
           clip-path="url(#clipPath3578)"><path
             d="m 3466.61,5399.62 75.59,18.9 -75.59,18.9 v -37.8"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3580" /><path
             d="m 3466.61,5399.62 75.59,18.9 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3582" /><path
             d="m 2701.91,5418.52 v 566.91 h 481.88 v -566.91 h 198.42"
             style="fill:none;stroke:#0000d1;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3584" /><path
             d="m 3835.73,5418.52 v 566.91 h 481.88 v -566.91 h 198.41"
             style="fill:none;stroke:#d10000;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3586" /></g></g><g
         id="g3588"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,256.08,618.46)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3598"><tspan
             x="0"
             y="0"
             id="tspan3590">σ</tspan><tspan
             x="90.719902 204.12024"
             y="90.719902"
             sodipodi:role="line"
             id="tspan3592">tt</tspan><tspan
             x="113.4"
             y="0"
             id="tspan3594">ε</tspan><tspan
             x="56.639801"
             y="90.719902"
             id="tspan3596">t</tspan></text><text
           transform="matrix(1,0,0,-1,316.9198,525.9401)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3602"><tspan
             x="0"
             y="0"
             id="tspan3600">1</tspan></text><text
           transform="matrix(1,0,0,-1,426.1198,527.7401)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3606"><tspan
             x="0"
             y="0"
             id="tspan3604">t</tspan></text><text
           transform="matrix(1,0,0,-1,430.3198,525.9401)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3610"><tspan
             x="0"
             y="0"
             id="tspan3608">1</tspan></text><text
           transform="matrix(1,0,0,-1,363.8397,595.7799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3614"><tspan
             x="0"
             y="0"
             id="tspan3612">ε</tspan></text><text
           transform="matrix(1,0,0,-1,369.36001,593.9799)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3618"><tspan
             x="0 3.7191429"
             y="0"
             sodipodi:role="line"
             id="tspan3616">el</tspan></text><text
           transform="matrix(1,0,0,-1,256.68001,595.7799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3622"><tspan
             x="0"
             y="0"
             id="tspan3620">˜</tspan></text><text
           transform="matrix(1,0,0,-1,256.08001,595.7799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3626"><tspan
             x="0"
             y="0"
             id="tspan3624">σ</tspan></text></g><g
         id="g3628"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,443.16,595.78)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3632"><tspan
             x="0"
             y="0"
             id="tspan3630">ε</tspan></text><text
           transform="matrix(1,0,0,-1,448.67992,593.98)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3636"><tspan
             x="0 3.7191672"
             y="0"
             sodipodi:role="line"
             id="tspan3634">el</tspan></text><text
           transform="matrix(1,0,0,-1,458.51976,595.78)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3640"><tspan
             x="0"
             y="0"
             id="tspan3638">=</tspan></text><text
           transform="matrix(1,0,0,-1,473.39986,600.46008)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3644"><tspan
             x="0"
             y="0"
             id="tspan3642">˜</tspan></text><text
           transform="matrix(1,0,0,-1,472.91978,600.46008)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3648"><tspan
             x="0"
             y="0"
             id="tspan3646">σ</tspan></text></g><g
         id="g3650"
         transform="matrix(67.2,0,0,-4.8,4721.88,5990.08)"><rect
           x="0"
           y="0"
           width="1"
           height="1"
           transform="matrix(1,0,0,-1,0,1)"
           style="fill:#000000;fill-opacity:1;fill-rule:nonzero"
           id="rect3652" /></g><g
         id="g3654"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,472.2,591.58)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3658"><tspan
             x="0"
             y="0"
             id="tspan3656">E</tspan></text><text
           transform="matrix(1,0,0,-1,107.76,563.0198)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3662"><tspan
             x="0"
             y="0"
             id="tspan3660">σ</tspan></text><text
           transform="matrix(1,0,0,-1,118.0799,563.0198)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3666"><tspan
             x="0"
             y="0"
             id="tspan3664">=</tspan></text><text
           transform="matrix(1,0,0,-1,130.56,563.0198)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3670"><tspan
             x="0 11.400024"
             y="0"
             sodipodi:role="line"
             id="tspan3668">Eε</tspan></text><text
           transform="matrix(1,0,0,-1,189.96,563.0198)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3674"><tspan
             x="0 4.5636959 10.438207 13.679145 19.553631"
             y="0"
             sodipodi:role="line"
             id="tspan3672">(1.1)</tspan></text><text
           transform="matrix(1,0,0,-1,107.76,540.3401)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3678"><tspan
             x="0"
             y="0"
             id="tspan3676">E</tspan></text><text
           transform="matrix(1,0,0,-1,117.12016,540.3401)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3682">elastic modulus</text><text
           transform="matrix(1,0,0,-1,85.07996,491.3799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFBX1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3686">Newtonian damping element</text><text
           transform="matrix(1,0,0,-1,273.35996,491.3799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3690">viscous behavior</text></g><g
         id="g3692"><g
           id="g3694"
           clip-path="url(#clipPath3698)"><path
             d="m 1900.43,4509.21 h 177"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3700" /></g></g><g
         id="g3702"><g
           id="g3704"
           clip-path="url(#clipPath3708)"><path
             d="m 2010.66,4495.36 56.69,13.85 -56.69,14.49 v -28.34"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3710" /><path
             d="m 2010.66,4495.36 56.69,13.85 -56.69,14.49 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3712" /></g></g><g
         id="g3714"><g
           id="g3716"
           clip-path="url(#clipPath3720)"><g
             id="g3722"
             clip-path="url(#clipPath3726)"><path
               d="M 1262.96,4509.21 H 1085.33"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path3728" /></g></g></g><g
         id="g3730"><g
           id="g3732"
           clip-path="url(#clipPath3736)"><path
             d="m 1152.1,4523.7 -56.69,-14.49 56.69,-13.85 v 28.34"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3738" /><path
             d="m 1152.1,4523.7 -56.69,-14.49 56.69,-13.85 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3740" /><path
             d="m 1333.52,4509.21 h 141.72"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3742" /><path
             d="m 1723.42,4580.39 h -248.18 v -141.72 h 248.18"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3744" /><path
             d="M 1829.88,4509.21 H 1581.7"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3746" /><path
             d="M 1581.7,4564.65 V 4451.27"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3748" /></g></g><g
         id="g3750"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,156.6,465.22)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3756"><tspan
             x="0"
             y="0"
             id="tspan3752">η</tspan><tspan
             x="-38.8801 37.680283"
             y="8.6398401"
             sodipodi:role="line"
             id="tspan3754">σσ</tspan></text></g><g
         id="g3758"><g
           id="g3760"
           clip-path="url(#clipPath3764)"><path
             d="m 3807.39,4475.83 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3766" /><path
             d="m 4232.57,3937.27 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3768" /></g></g><g
         id="g3770"><g
           id="g3772"
           clip-path="url(#clipPath3776)"><path
             d="m 3552.28,3908.92 h -935.4"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3778" /></g></g><g
         id="g3780"><g
           id="g3782"
           clip-path="url(#clipPath3786)"><path
             d="m 3466.61,3890.03 75.59,18.89 -75.59,18.9 v -37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3788" /><path
             d="m 3466.61,3890.03 75.59,18.89 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3790" /></g></g><g
         id="g3792"><g
           id="g3794"
           clip-path="url(#clipPath3798)"><path
             d="M 3835.73,4759.29 V 3908.92"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3800" /></g></g><g
         id="g3802"><g
           id="g3804"
           clip-path="url(#clipPath3808)"><path
             d="m 3854.63,4673.62 -18.9,75.59 -18.89,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3810" /><path
             d="m 3854.63,4673.62 -18.9,75.59 -18.89,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3812" /></g></g><g
         id="g3814"><g
           id="g3816"
           clip-path="url(#clipPath3820)"><path
             d="M 4686.1,3908.92 H 3750.7"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3822" /></g></g><g
         id="g3824"><g
           id="g3826"
           clip-path="url(#clipPath3830)"><path
             d="m 4600.43,3890.03 75.59,18.89 -75.59,18.9 v -37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3832" /><path
             d="m 4600.43,3890.03 75.59,18.89 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3834" /><path
             d="m 2673.57,4475.83 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3836" /></g></g><g
         id="g3838"><g
           id="g3840"
           clip-path="url(#clipPath3844)"><path
             d="M 2701.91,4759.29 V 3908.92"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3846" /></g></g><g
         id="g3848"><g
           id="g3850"
           clip-path="url(#clipPath3854)"><path
             d="m 2720.81,4673.62 -18.9,75.59 -18.89,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path3856" /><path
             d="m 2720.81,4673.62 -18.9,75.59 -18.89,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3858" /><path
             d="m 3098.75,3937.27 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3860" /><path
             d="m 3835.73,3908.92 396.84,566.91 h 283.45"
             style="fill:none;stroke:#d10000;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3862" /><path
             d="M 4119.19,4305.76 V 4135.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3864" /><path
             d="M 4119.19,4135.69 H 4005.8"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3866" /><path
             d="m 2701.91,3908.92 v 566.91 h 396.84 v -566.91 h 283.46"
             style="fill:none;stroke:#0000d1;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path3868" /></g></g><g
         id="g3870"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,256.08,467.38)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3876"><tspan
             x="0"
             y="0"
             id="tspan3872">σ</tspan><tspan
             x="90.719902 51"
             y="90.719902"
             sodipodi:role="line"
             id="tspan3874">tt</tspan></text><text
           transform="matrix(1,0,0,-1,311.28,374.8601)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3880"><tspan
             x="0"
             y="0"
             id="tspan3878">1</tspan></text><text
           transform="matrix(1,0,0,-1,366.5999,467.38)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3886"><tspan
             x="0"
             y="0"
             id="tspan3882">ε</tspan><tspan
             x="93.599998 53.8801"
             y="90.719902"
             sodipodi:role="line"
             id="tspan3884">tt</tspan></text><text
           transform="matrix(1,0,0,-1,424.68,374.8601)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3890"><tspan
             x="0"
             y="0"
             id="tspan3888">1</tspan></text><text
           transform="matrix(1,0,0,-1,355.3198,444.6999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3894"><tspan
             x="0"
             y="0"
             id="tspan3892">ε</tspan></text><text
           transform="matrix(1,0,0,-1,360.83972,444.6999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3898"><tspan
             x="0"
             y="0"
             id="tspan3896">(</tspan></text><text
           transform="matrix(1,0,0,-1,365.39988,444.6999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3902"><tspan
             x="0"
             y="0"
             id="tspan3900">t</tspan></text><text
           transform="matrix(1,0,0,-1,369.59988,442.8999)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3906"><tspan
             x="0"
             y="0"
             id="tspan3904">1</tspan></text><text
           transform="matrix(1,0,0,-1,374.27996,444.6999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3914"><tspan
             x="0"
             y="0"
             id="tspan3908">)</tspan><tspan
             x="29.1598"
             y="42.599998"
             id="tspan3910">1</tspan><tspan
             x="-117.6002"
             y="-7.1054274e-15"
             id="tspan3912">˜</tspan></text><text
           transform="matrix(1,0,0,-1,256.07976,444.6999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3918"><tspan
             x="0"
             y="0"
             id="tspan3916">σ</tspan></text><text
           transform="matrix(1,0,0,-1,416.51976,423.8198)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3922"><tspan
             x="0"
             y="0"
             id="tspan3920">˜</tspan></text><text
           transform="matrix(1,0,0,-1,416.03968,423.8198)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3926"><tspan
             x="0"
             y="0"
             id="tspan3924">σ</tspan></text></g><g
         id="g3928"
         transform="matrix(51.6,0,0,-4.8,4160.28,4223.68)"><rect
           x="0"
           y="0"
           width="1"
           height="1"
           transform="matrix(1,0,0,-1,0,1)"
           style="fill:#000000;fill-opacity:1;fill-rule:nonzero"
           id="rect3930" /></g><g
         id="g3932"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,416.28,415.06)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3936"><tspan
             x="0"
             y="0"
             id="tspan3934">η</tspan></text><text
           transform="matrix(1,0,0,-1,462.9601,444.6998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3940"><tspan
             x="0"
             y="0"
             id="tspan3938">ε</tspan></text><text
           transform="matrix(1,0,0,-1,468.48002,444.6998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3944"><tspan
             x="0"
             y="0"
             id="tspan3942">(</tspan></text><text
           transform="matrix(1,0,0,-1,473.04018,444.6998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3948"><tspan
             x="0"
             y="0"
             id="tspan3946">t</tspan></text><text
           transform="matrix(1,0,0,-1,477.23979,442.8998)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3952"><tspan
             x="0"
             y="0"
             id="tspan3950">1</tspan></text><text
           transform="matrix(1,0,0,-1,482.03979,444.6998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3956"><tspan
             x="0 7.800015"
             y="0"
             sodipodi:role="line"
             id="tspan3954">)=</tspan></text><text
           transform="matrix(1,0,0,-1,503.87999,449.37988)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3960"><tspan
             x="0"
             y="0"
             id="tspan3958">˜</tspan></text><text
           transform="matrix(1,0,0,-1,503.51983,449.37988)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3964"><tspan
             x="0"
             y="0"
             id="tspan3962">σ</tspan></text></g><g
         id="g3966"
         transform="matrix(51.6,0,0,-4.8,5035.08,4479.28)"><rect
           x="0"
           y="0"
           width="1"
           height="1"
           transform="matrix(1,0,0,-1,0,1)"
           style="fill:#000000;fill-opacity:1;fill-rule:nonzero"
           id="rect3968" /></g><g
         id="g3970"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,503.76,440.5)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3974"><tspan
             x="0"
             y="0"
             id="tspan3972">η</tspan></text><text
           transform="matrix(1,0,0,-1,511.79984,444.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3978"><tspan
             x="0"
             y="0"
             id="tspan3976">t</tspan></text><text
           transform="matrix(1,0,0,-1,515.99984,442.9)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3982"><tspan
             x="0"
             y="0"
             id="tspan3980">1</tspan></text></g><g
         id="g3984"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,107.76,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3988"><tspan
             x="0"
             y="0"
             id="tspan3986">σ</tspan></text><text
           transform="matrix(1,0,0,-1,118.0799,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3992"><tspan
             x="0"
             y="0"
             id="tspan3990">=</tspan></text><text
           transform="matrix(1,0,0,-1,130.56,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text3996"><tspan
             x="0"
             y="0"
             id="tspan3994">η</tspan></text><text
           transform="matrix(1,0,0,-1,140.8799,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4000"><tspan
             x="0"
             y="0"
             id="tspan3998">˙</tspan></text><text
           transform="matrix(1,0,0,-1,138.71974,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4004"><tspan
             x="0"
             y="0"
             id="tspan4002">ε</tspan></text><text
           transform="matrix(1,0,0,-1,189.95954,417.7)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4008"><tspan
             x="0 4.5636959 10.438207 13.679145 19.553631"
             y="0"
             sodipodi:role="line"
             id="tspan4006">(1.2)</tspan></text><text
           transform="matrix(1,0,0,-1,107.75994,395.0199)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4012"><tspan
             x="0"
             y="0"
             id="tspan4010">η</tspan></text><text
           transform="matrix(1,0,0,-1,113.99978,395.0199)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4016"> viscosity</text><text
           transform="matrix(1,0,0,-1,85.07988,345.9402)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFBX1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4020">St.Venant friction element:</text><text
           transform="matrix(1,0,0,-1,290.87988,345.9402)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4024">ideal plastic behavior</text></g><g
         id="g4026"><g
           id="g4028"
           clip-path="url(#clipPath4032)"><g
             id="g4034"
             clip-path="url(#clipPath4038)"><path
               d="M 1262.96,2998.47 H 1085.33"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path4040" /></g></g></g><g
         id="g4042"><g
           id="g4044"
           clip-path="url(#clipPath4048)"><path
             d="m 1152.1,3012.96 -56.69,-14.49 56.69,-13.86 v 28.35"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4050" /><path
             d="m 1152.1,3012.96 -56.69,-14.49 56.69,-13.86 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4052" /><path
             d="m 1333.52,2998.47 h 297.94 v 85.04"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4054" /><path
             d="m 1829.88,3083.51 h -311.81 v -85.04"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4056" /></g></g><g
         id="g4058"><g
           id="g4060"
           clip-path="url(#clipPath4064)"><path
             d="m 1914.91,3083.51 h 177"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4066" /></g></g><g
         id="g4068"><g
           id="g4070"
           clip-path="url(#clipPath4074)"><path
             d="m 2025.14,3069.65 56.7,13.86 -56.7,14.48 v -28.34"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4076" /><path
             d="m 2025.14,3069.65 56.7,13.86 -56.7,14.48 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4078" /></g></g><g
         id="g4080"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,117.72,305.62)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4086"><tspan
             x="0"
             y="0"
             id="tspan4082">σ</tspan><tspan
             x="34.080101"
             y="-11.2801"
             id="tspan4084">σ</tspan></text><text
           transform="matrix(1,0,0,-1,158.4001,315.1001)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4090"><tspan
             x="0"
             y="0"
             id="tspan4088">F</tspan></text><text
           transform="matrix(1,0,0,-1,194.2802,314.02002)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4094"><tspan
             x="0"
             y="0"
             id="tspan4092">σ</tspan></text></g><g
         id="g4096"><g
           id="g4098"
           clip-path="url(#clipPath4102)"><path
             d="m 3155.37,2936.23 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4104" /><path
             d="m 4289.19,2936.23 h 56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4106" /><path
             d="m 3467.17,2397.67 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4108" /><path
             d="m 3693.93,2397.67 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4110" /><path
             d="m 4600.99,2397.67 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4112" /><path
             d="m 4827.75,2397.67 v -56.69"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4114" /></g></g><g
         id="g4116"><g
           id="g4118"
           clip-path="url(#clipPath4122)"><path
             d="M 3183.71,3219.69 V 2369.32"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4124" /></g></g><g
         id="g4126"><g
           id="g4128"
           clip-path="url(#clipPath4132)"><path
             d="m 3202.61,3134.02 -18.9,75.59 -18.89,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4134" /><path
             d="m 3202.61,3134.02 -18.9,75.59 -18.89,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4136" /></g></g><g
         id="g4138"><g
           id="g4140"
           clip-path="url(#clipPath4144)"><path
             d="m 4034.08,2369.32 h -935.4"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4146" /></g></g><g
         id="g4148"><g
           id="g4150"
           clip-path="url(#clipPath4154)"><path
             d="m 3948.41,2350.43 75.59,18.89 -75.59,18.9 v -37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4156" /><path
             d="m 3948.41,2350.43 75.59,18.89 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4158" /></g></g><g
         id="g4160"><g
           id="g4162"
           clip-path="url(#clipPath4166)"><path
             d="M 4317.54,3219.69 V 2369.32"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4168" /></g></g><g
         id="g4170"><g
           id="g4172"
           clip-path="url(#clipPath4176)"><path
             d="m 4336.43,3134.02 -18.89,75.59 -18.9,-75.59 h 37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4178" /><path
             d="m 4336.43,3134.02 -18.89,75.59 -18.9,-75.59 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4180" /></g></g><g
         id="g4182"><g
           id="g4184"
           clip-path="url(#clipPath4188)"><g
             id="g4190"
             clip-path="url(#clipPath4194)"><path
               d="M 5167.9,2369.32 H 4232.5"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path4196" /></g></g></g><g
         id="g4198"><g
           id="g4200"
           clip-path="url(#clipPath4204)"><path
             d="m 5082.23,2350.43 75.59,18.89 -75.59,18.9 v -37.79"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path4206" /><path
             d="m 5082.23,2350.43 75.59,18.89 -75.59,18.9 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4208" /><path
             d="m 4317.54,2369.32 h 283.45 l 226.76,566.91 h 170.07"
             style="fill:none;stroke:#d10000;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4210" /><path
             d="m 3183.71,2369.32 283.46,566.91 h 226.76 V 2369.32 H 3864"
             style="fill:none;stroke:#0000d1;stroke-width:18.897;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path4212" /></g></g><g
         id="g4214"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,304.2,313.42)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4220"><tspan
             x="0"
             y="0"
             id="tspan4216">σ</tspan><tspan
             x="-5.6398401"
             y="22.679701"
             id="tspan4218">σ</tspan></text><text
           transform="matrix(1,0,0,-1,305.16016,288.9403)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4224"><tspan
             x="0"
             y="0"
             id="tspan4222">F</tspan></text><text
           transform="matrix(1,0,0,-1,394.91996,222.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4228"><tspan
             x="0 -53.760201"
             y="0"
             sodipodi:role="line"
             id="tspan4226">tt</tspan></text><text
           transform="matrix(1,0,0,-1,345.36015,220.9001)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4232"><tspan
             x="0"
             y="0"
             id="tspan4230">1</tspan></text><text
           transform="matrix(1,0,0,-1,363.83985,222.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4236"><tspan
             x="0"
             y="0"
             id="tspan4234">t</tspan></text><text
           transform="matrix(1,0,0,-1,368.03985,220.9001)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4240"><tspan
             x="0"
             y="0"
             id="tspan4238">2</tspan></text><text
           transform="matrix(1,0,0,-1,454.43985,222.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4244"><tspan
             x="0"
             y="0"
             id="tspan4242">t</tspan></text><text
           transform="matrix(1,0,0,-1,458.63985,220.9001)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4248"><tspan
             x="0"
             y="0"
             id="tspan4246">1</tspan></text><text
           transform="matrix(1,0,0,-1,477.11995,222.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4252"><tspan
             x="0"
             y="0"
             id="tspan4250">t</tspan></text><text
           transform="matrix(1,0,0,-1,481.31995,220.9001)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR8;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4256"><tspan
             x="0"
             y="0"
             id="tspan4254">2</tspan></text><text
           transform="matrix(1,0,0,-1,508.31995,222.7001)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4262"><tspan
             x="0"
             y="0"
             id="tspan4258">t</tspan><tspan
             x="-90.719902"
             y="-90.719902"
             id="tspan4260">ε</tspan></text></g><g
         id="g4264"
         transform="matrix(10,0,0,10,-15,0)"><text
           transform="matrix(1,0,0,-1,107.76,272.26)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4268"><tspan
             x="0 10.319956 22.80006"
             y="0"
             sodipodi:role="line"
             id="tspan4266">σ&lt;σ</tspan></text><text
           transform="matrix(1,0,0,-1,137.16,270.46)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4272"><tspan
             x="0"
             y="0"
             id="tspan4270">F</tspan></text><text
           transform="matrix(1,0,0,-1,143.16,272.26)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4276"><tspan
             x="0"
             y="0"
             id="tspan4274">:</tspan></text><text
           transform="matrix(1,0,0,-1,162.1202,272.26)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4280"><tspan
             x="0"
             y="0"
             id="tspan4278">ε</tspan></text><text
           transform="matrix(1,0,0,-1,170.88036,272.26)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4284"><tspan
             x="0 12.360183"
             y="0"
             sodipodi:role="line"
             id="tspan4282">=0</tspan></text><text
           transform="matrix(1,0,0,-1,193.08036,272.26)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4288">cling</text><text
           transform="matrix(1,0,0,-1,107.76006,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4292"><tspan
             x="0 10.319956 22.80006"
             y="0"
             sodipodi:role="line"
             id="tspan4290">σ&gt;σ</tspan></text><text
           transform="matrix(1,0,0,-1,137.16006,247.7799)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4296"><tspan
             x="0"
             y="0"
             id="tspan4294">F</tspan></text><text
           transform="matrix(1,0,0,-1,143.16006,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4300"><tspan
             x="0"
             y="0"
             id="tspan4298">:</tspan></text><text
           transform="matrix(1,0,0,-1,162.12026,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4304"><tspan
             x="0"
             y="0"
             id="tspan4302">ε</tspan></text><text
           transform="matrix(1,0,0,-1,170.88042,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMSY10;-inkscape-font-specification:CMSY10;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4308"><tspan
             x="0"
             y="0"
             id="tspan4306"> </tspan></text><text
           transform="matrix(1,0,0,-1,170.88042,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMR12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4312"><tspan
             x="0 12.360183"
             y="0"
             sodipodi:role="line"
             id="tspan4310">≠0</tspan></text><text
           transform="matrix(1,0,0,-1,189.12062,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4316"><tspan
             x="0"
             y="0"
             id="tspan4314">,</tspan></text><text
           transform="matrix(1,0,0,-1,196.32062,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4320"><tspan
             x="0"
             y="0"
             id="tspan4318">ε</tspan></text><text
           transform="matrix(1,0,0,-1,205.08078,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMSY10;-inkscape-font-specification:CMSY10;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4324"><tspan
             x="0 15.23988"
             y="0"
             sodipodi:role="line"
             id="tspan4322">→∞</tspan></text><text
           transform="matrix(1,0,0,-1,236.28078,249.5799)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4328">friction</text><text
           transform="matrix(1,0,0,-1,107.75978,226.8998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4332"><tspan
             x="0"
             y="0"
             id="tspan4330">σ</tspan></text><text
           transform="matrix(1,0,0,-1,114.35978,225.0998)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4336"><tspan
             x="0"
             y="0"
             id="tspan4334">F</tspan></text><text
           transform="matrix(1,0,0,-1,120.35978,226.8998)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:"Alegreya Sans, sans-serif";-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text4350"> yield stress<tspan
             x="0"
             y="14.944"
             sodipodi:role="line"
             id="tspan4348" /></text></g></g></g></svg>
""";

# ╔═╡ 8ba8a6e9-fef9-45cb-964b-1ab97e2436d4
HTML(theorie1)

# ╔═╡ 2c6c389e-95aa-46a7-af90-887221f1fa3c
md"""
By connecting Hooke's spring and Newton's damper in series and in parallel, one obtains the Maxwell model and the Kelvin-Voigt model respectively.
Their constant stress and constant strain behaviour is shown in the table below.
"""

# ╔═╡ 01de02df-e4e3-43da-b6fa-fcaee55e7eb2
theorie2="""<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   width="595"
   height="842"
   viewBox="0 0 595 842"
   version="1.1"
   id="svg2493"
   sodipodi:docname="theorie2.svg"
   inkscape:version="1.2.1 (9c6d41e410, 2022-07-14, custom)"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <sodipodi:namedview
     id="namedview2495"
     pagecolor="#505050"
     bordercolor="#eeeeee"
     borderopacity="1"
     inkscape:showpageshadow="0"
     inkscape:pageopacity="0"
     inkscape:pagecheckerboard="0"
     inkscape:deskcolor="#505050"
     showgrid="false"
     inkscape:zoom="0.7927658"
     inkscape:cx="251.01991"
     inkscape:cy="398.60448"
     inkscape:window-width="1918"
     inkscape:window-height="1057"
     inkscape:window-x="0"
     inkscape:window-y="21"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg2493" />
  <defs
     id="defs609">
    <g
       id="g406">
      <g
         id="glyph-0-0" />
      <g
         id="glyph-0-1">
        <path
           d="M 1.640625 -7.09375 L 1.96875 -7.09375 C 2.3125 -7.09375 2.625 -7.0625 2.625 -6.78125 C 2.625 -6.671875 2.578125 -6.546875 2.578125 -6.453125 L 1.671875 -1.015625 C 1.578125 -0.453125 1.53125 -0.34375 0.5 -0.34375 L 0.453125 -0.015625 L 6.484375 -0.015625 L 6.609375 -0.03125 L 6.703125 -0.234375 L 7.53125 -2.8125 L 7.390625 -2.8125 C 7.21875 -2.8125 7.21875 -2.71875 7.203125 -2.625 C 7.03125 -2.0625 6.75 -1.234375 6.21875 -0.8125 C 5.65625 -0.359375 4.90625 -0.34375 4.21875 -0.34375 L 3.453125 -0.34375 C 3.328125 -0.34375 3.203125 -0.328125 3.0625 -0.328125 L 3.015625 -0.328125 C 2.8125 -0.328125 2.515625 -0.34375 2.515625 -0.5625 C 2.515625 -0.625 2.53125 -0.703125 2.546875 -0.78125 L 2.984375 -3.390625 C 2.984375 -3.484375 3.015625 -3.59375 3.015625 -3.703125 L 4.0625 -3.703125 C 4.53125 -3.703125 5.0625 -3.640625 5.0625 -3 C 5.0625 -2.796875 5.015625 -2.609375 5 -2.421875 L 5.25 -2.421875 L 5.734375 -5.296875 L 5.578125 -5.296875 C 5.40625 -5.296875 5.4375 -5.03125 5.40625 -4.890625 C 5.21875 -4.15625 4.734375 -4.015625 3.796875 -4.015625 C 3.5625 -4.015625 3.328125 -4.03125 3.09375 -4.03125 C 3.109375 -4.28125 3.15625 -4.53125 3.203125 -4.78125 L 3.453125 -6.21875 C 3.53125 -6.640625 3.453125 -7.09375 3.984375 -7.09375 L 5.375 -7.09375 C 6.328125 -7.09375 7.34375 -7.0625 7.34375 -5.59375 C 7.34375 -5.390625 7.328125 -5.1875 7.328125 -4.984375 L 7.59375 -4.984375 L 7.703125 -7.421875 L 1.8125 -7.421875 L 1.703125 -7.40625 L 1.671875 -7.3125 Z M 1.640625 -7.09375 "
           id="path3" />
      </g>
      <g
         id="glyph-0-2">
        <path
           d="M 1.1875 -4.6875 L 1.140625 -4.359375 L 1.28125 -4.359375 C 1.546875 -4.359375 1.859375 -4.34375 1.859375 -4.03125 C 1.859375 -3.78125 1.78125 -3.515625 1.75 -3.265625 L 1.34375 -0.875 C 1.3125 -0.765625 1.3125 -0.640625 1.265625 -0.546875 C 1.140625 -0.34375 0.890625 -0.34375 0.671875 -0.34375 L 0.515625 -0.34375 C 0.375 -0.34375 0.390625 -0.140625 0.375 -0.015625 L 2.65625 -0.046875 L 2.71875 -0.34375 L 2.515625 -0.34375 C 2.3125 -0.34375 2.015625 -0.34375 2.015625 -0.609375 C 2.015625 -0.703125 2.046875 -0.78125 2.046875 -0.84375 L 2.640625 -4.390625 C 2.65625 -4.53125 2.6875 -4.671875 2.703125 -4.8125 Z M 2.5 -7.265625 C 2.203125 -7.234375 1.953125 -6.953125 1.953125 -6.65625 C 1.953125 -6.390625 2.15625 -6.1875 2.421875 -6.1875 C 2.75 -6.1875 3.046875 -6.46875 3.046875 -6.796875 C 3.046875 -7.0625 2.859375 -7.28125 2.578125 -7.28125 C 2.5625 -7.28125 2.53125 -7.265625 2.5 -7.265625 Z M 2.5 -7.265625 "
           id="path6" />
      </g>
      <g
         id="glyph-0-3">
        <path
           d="M 1.140625 -4.6875 L 1.078125 -4.359375 L 1.21875 -4.359375 C 1.515625 -4.359375 1.84375 -4.34375 1.84375 -4.015625 C 1.84375 -3.96875 1.828125 -3.921875 1.828125 -3.875 L 1.328125 -0.875 C 1.3125 -0.765625 1.296875 -0.640625 1.25 -0.546875 C 1.140625 -0.34375 0.875 -0.34375 0.671875 -0.34375 L 0.5 -0.34375 C 0.375 -0.34375 0.375 -0.140625 0.359375 -0.015625 L 2.734375 -0.03125 L 2.78125 -0.109375 L 2.8125 -0.34375 L 2.5625 -0.34375 C 2.3125 -0.34375 2.046875 -0.359375 2.046875 -0.59375 C 2.046875 -0.671875 2.046875 -0.734375 2.0625 -0.796875 L 2.359375 -2.515625 C 2.40625 -2.796875 2.4375 -3.0625 2.53125 -3.3125 C 2.796875 -3.96875 3.40625 -4.578125 4.171875 -4.578125 C 4.609375 -4.578125 4.796875 -4.265625 4.796875 -3.859375 C 4.796875 -3.484375 4.703125 -3.09375 4.640625 -2.71875 L 4.3125 -0.78125 C 4.25 -0.359375 3.96875 -0.34375 3.65625 -0.34375 L 3.53125 -0.34375 C 3.375 -0.34375 3.359375 -0.15625 3.359375 -0.015625 L 5.734375 -0.03125 L 5.78125 -0.109375 L 5.8125 -0.34375 L 5.625 -0.34375 C 5.40625 -0.34375 5.0625 -0.34375 5.03125 -0.578125 L 5.03125 -0.625 C 5.03125 -0.703125 5.0625 -0.78125 5.078125 -0.875 L 5.4375 -3.046875 C 5.46875 -3.265625 5.515625 -3.5 5.515625 -3.734375 C 5.515625 -4.609375 4.859375 -4.8125 4.203125 -4.8125 C 3.515625 -4.8125 2.765625 -4.28125 2.515625 -3.734375 L 2.5 -3.734375 L 2.671875 -4.8125 Z M 1.140625 -4.6875 "
           id="path9" />
      </g>
      <g
         id="glyph-0-4">
        <path
           d="M 1.984375 -4.703125 L 1.140625 -4.703125 L 1.078125 -4.375 L 1.921875 -4.375 C 1.890625 -4.09375 1.828125 -3.8125 1.78125 -3.546875 L 1.375 -1.0625 C 1.359375 -0.921875 1.34375 -0.734375 1.28125 -0.59375 C 1.1875 -0.34375 0.890625 -0.34375 0.671875 -0.34375 L 0.515625 -0.34375 C 0.375 -0.34375 0.390625 -0.140625 0.375 -0.015625 L 1.578125 -0.046875 L 2.953125 -0.046875 L 3 -0.34375 C 2.890625 -0.34375 2.765625 -0.328125 2.640625 -0.328125 C 2.328125 -0.328125 2.03125 -0.375 2.03125 -0.625 C 2.03125 -0.6875 2.03125 -0.734375 2.046875 -0.78125 L 2.59375 -4.109375 C 2.625 -4.21875 2.578125 -4.375 2.75 -4.375 L 3.890625 -4.375 L 3.953125 -4.703125 L 2.65625 -4.703125 C 2.703125 -5.015625 2.765625 -5.328125 2.8125 -5.65625 C 2.890625 -6.078125 2.96875 -6.5 3.21875 -6.875 C 3.40625 -7.15625 3.71875 -7.453125 4.078125 -7.453125 C 4.203125 -7.453125 4.34375 -7.421875 4.453125 -7.390625 C 4.234375 -7.28125 4.0625 -7.140625 4.0625 -6.875 C 4.0625 -6.6875 4.203125 -6.5 4.453125 -6.5 C 4.734375 -6.5 4.96875 -6.734375 4.96875 -7.03125 C 4.96875 -7.484375 4.5 -7.6875 4.109375 -7.6875 C 3.28125 -7.6875 2.546875 -7.09375 2.28125 -6.34375 C 2.1875 -6.0625 2.15625 -5.765625 2.109375 -5.46875 C 2.0625 -5.21875 2 -4.953125 1.984375 -4.703125 Z M 1.984375 -4.703125 "
           id="path12" />
      </g>
      <g
         id="glyph-0-5">
        <path
           d="M 1.140625 -4.6875 L 1.078125 -4.359375 L 1.203125 -4.359375 C 1.4375 -4.359375 1.84375 -4.359375 1.84375 -4.046875 C 1.84375 -3.9375 1.828125 -3.84375 1.8125 -3.734375 L 1.46875 -1.703125 C 1.421875 -1.46875 1.390625 -1.234375 1.390625 -1 C 1.390625 -0.09375 2.15625 0.09375 2.828125 0.09375 C 3.453125 0.09375 4.125 -0.328125 4.34375 -0.84375 L 4.359375 -0.84375 L 4.203125 0.09375 L 5.75 -0.015625 L 5.8125 -0.34375 L 5.671875 -0.34375 C 5.375 -0.34375 5.046875 -0.359375 5.046875 -0.6875 C 5.046875 -0.765625 5.078125 -0.84375 5.078125 -0.921875 L 5.65625 -4.390625 C 5.6875 -4.53125 5.71875 -4.671875 5.71875 -4.8125 L 4.140625 -4.6875 L 4.078125 -4.359375 L 4.265625 -4.359375 C 4.53125 -4.359375 4.84375 -4.328125 4.84375 -4.03125 C 4.84375 -3.75 4.765625 -3.453125 4.71875 -3.1875 L 4.5625 -2.21875 C 4.515625 -1.984375 4.484375 -1.734375 4.421875 -1.5 C 4.1875 -0.78125 3.625 -0.125 2.859375 -0.125 C 2.515625 -0.125 2.078125 -0.234375 2.078125 -0.71875 C 2.078125 -0.984375 2.140625 -1.25 2.1875 -1.5 L 2.625 -4.09375 C 2.65625 -4.328125 2.703125 -4.5625 2.71875 -4.8125 Z M 5.203125 -7.125 C 4.90625 -7.09375 4.65625 -6.828125 4.65625 -6.515625 C 4.65625 -6.265625 4.859375 -6.046875 5.125 -6.046875 C 5.4375 -6.046875 5.765625 -6.328125 5.765625 -6.65625 C 5.765625 -6.921875 5.546875 -7.140625 5.296875 -7.140625 C 5.265625 -7.140625 5.234375 -7.125 5.203125 -7.125 Z M 3.09375 -7.125 C 2.796875 -7.09375 2.546875 -6.828125 2.546875 -6.515625 C 2.546875 -6.265625 2.765625 -6.046875 3.046875 -6.046875 L 3.109375 -6.046875 C 3.390625 -6.109375 3.65625 -6.359375 3.65625 -6.65625 C 3.65625 -6.921875 3.453125 -7.140625 3.171875 -7.140625 C 3.15625 -7.140625 3.125 -7.125 3.09375 -7.125 Z M 3.09375 -7.125 "
           id="path15" />
      </g>
      <g
         id="glyph-0-6">
        <path
           d="M 1.59375 -7.453125 L 1.546875 -7.125 L 1.6875 -7.125 C 2 -7.125 2.3125 -7.109375 2.3125 -6.765625 C 2.3125 -6.609375 2.25 -6.453125 2.234375 -6.296875 L 1.375 -1.15625 C 1.359375 -0.984375 1.328125 -0.796875 1.28125 -0.625 C 1.203125 -0.359375 0.921875 -0.34375 0.671875 -0.34375 L 0.515625 -0.34375 C 0.359375 -0.34375 0.375 -0.140625 0.359375 -0.015625 L 2.734375 -0.03125 L 2.78125 -0.109375 L 2.8125 -0.34375 L 2.5625 -0.34375 C 2.3125 -0.34375 2.046875 -0.359375 2.046875 -0.59375 C 2.046875 -0.671875 2.046875 -0.734375 2.0625 -0.796875 L 2.359375 -2.515625 C 2.40625 -2.796875 2.4375 -3.0625 2.53125 -3.3125 C 2.796875 -3.96875 3.40625 -4.578125 4.171875 -4.578125 C 4.609375 -4.578125 4.796875 -4.265625 4.796875 -3.859375 C 4.796875 -3.484375 4.703125 -3.09375 4.640625 -2.71875 L 4.3125 -0.78125 C 4.25 -0.359375 3.96875 -0.34375 3.65625 -0.34375 L 3.53125 -0.34375 C 3.375 -0.34375 3.359375 -0.15625 3.359375 -0.015625 L 5.734375 -0.03125 L 5.78125 -0.109375 L 5.8125 -0.34375 L 5.625 -0.34375 C 5.40625 -0.34375 5.0625 -0.34375 5.03125 -0.578125 L 5.03125 -0.625 C 5.03125 -0.703125 5.0625 -0.78125 5.078125 -0.875 L 5.4375 -3.046875 C 5.46875 -3.265625 5.515625 -3.484375 5.515625 -3.71875 C 5.515625 -4.609375 4.859375 -4.8125 4.1875 -4.8125 L 4.078125 -4.8125 C 3.46875 -4.734375 2.8125 -4.328125 2.546875 -3.78125 L 2.53125 -3.78125 L 3.15625 -7.578125 Z M 1.59375 -7.453125 "
           id="path18" />
      </g>
      <g
         id="glyph-0-7">
        <path
           d="M 1.09375 -4.6875 L 1.03125 -4.359375 L 1.203125 -4.359375 C 1.484375 -4.359375 1.796875 -4.328125 1.796875 -4.03125 C 1.796875 -3.96875 1.78125 -3.921875 1.78125 -3.859375 L 1.28125 -0.8125 C 1.203125 -0.4375 1.09375 -0.34375 0.359375 -0.34375 L 0.3125 -0.015625 L 2.90625 -0.015625 L 2.953125 -0.34375 L 2.609375 -0.34375 C 2.28125 -0.34375 1.96875 -0.375 1.96875 -0.625 C 1.96875 -0.703125 1.984375 -0.78125 2 -0.84375 L 2.125 -1.640625 C 2.265625 -2.484375 2.359375 -3.375 2.9375 -4.0625 C 3.15625 -4.3125 3.515625 -4.578125 3.890625 -4.578125 C 3.9375 -4.578125 3.984375 -4.578125 4.03125 -4.5625 C 3.84375 -4.46875 3.703125 -4.3125 3.703125 -4.09375 C 3.703125 -3.875 3.828125 -3.78125 4.0625 -3.703125 L 4.09375 -3.703125 C 4.40625 -3.703125 4.609375 -3.96875 4.609375 -4.25 C 4.609375 -4.625 4.25 -4.8125 3.921875 -4.8125 C 3.25 -4.8125 2.578125 -4.171875 2.421875 -3.640625 L 2.40625 -3.640625 L 2.59375 -4.8125 Z M 1.09375 -4.6875 "
           id="path21" />
      </g>
      <g
         id="glyph-0-8">
        <path
           d="M 1.140625 -4.6875 L 1.078125 -4.359375 L 1.203125 -4.359375 C 1.4375 -4.359375 1.84375 -4.359375 1.84375 -4.046875 C 1.84375 -3.9375 1.828125 -3.84375 1.8125 -3.734375 L 1.46875 -1.703125 C 1.421875 -1.46875 1.390625 -1.234375 1.390625 -1 C 1.390625 -0.09375 2.15625 0.09375 2.828125 0.09375 C 3.453125 0.09375 4.125 -0.328125 4.34375 -0.84375 L 4.359375 -0.84375 L 4.203125 0.09375 L 5.75 -0.015625 L 5.8125 -0.34375 L 5.671875 -0.34375 C 5.375 -0.34375 5.046875 -0.359375 5.046875 -0.6875 C 5.046875 -0.765625 5.078125 -0.84375 5.078125 -0.921875 L 5.65625 -4.390625 C 5.6875 -4.53125 5.71875 -4.671875 5.71875 -4.8125 L 4.140625 -4.6875 L 4.078125 -4.359375 L 4.265625 -4.359375 C 4.53125 -4.359375 4.84375 -4.328125 4.84375 -4.03125 C 4.84375 -3.75 4.765625 -3.453125 4.71875 -3.1875 L 4.5625 -2.21875 C 4.515625 -1.984375 4.484375 -1.734375 4.421875 -1.5 C 4.1875 -0.78125 3.625 -0.125 2.859375 -0.125 C 2.515625 -0.125 2.078125 -0.234375 2.078125 -0.71875 C 2.078125 -0.984375 2.140625 -1.25 2.1875 -1.5 L 2.625 -4.09375 C 2.65625 -4.328125 2.703125 -4.5625 2.71875 -4.8125 Z M 1.140625 -4.6875 "
           id="path24" />
      </g>
      <g
         id="glyph-0-9">
        <path
           d="M 1.5 -2.125 L 1.5 -2.109375 C 1.21875 -1.890625 1 -1.421875 1 -1 C 1 -0.703125 1.109375 -0.453125 1.34375 -0.25 C 0.84375 -0.15625 0.15625 0.34375 0.15625 0.953125 C 0.15625 1.953125 1.609375 2.21875 2.359375 2.21875 C 3.4375 2.21875 4.984375 1.796875 4.984375 0.59375 C 4.984375 -0.5625 3.796875 -0.71875 2.90625 -0.71875 L 1.859375 -0.71875 C 1.53125 -0.78125 1.375 -1.015625 1.375 -1.3125 C 1.375 -1.5 1.5 -1.890625 1.640625 -1.9375 L 1.671875 -1.9375 C 1.734375 -1.9375 1.890625 -1.8125 2.015625 -1.765625 C 2.21875 -1.671875 2.453125 -1.625 2.6875 -1.625 C 3.671875 -1.625 4.703125 -2.4375 4.703125 -3.453125 C 4.703125 -3.78125 4.5625 -4.015625 4.421875 -4.28125 C 4.75 -4.453125 5.046875 -4.703125 5.46875 -4.703125 C 5.515625 -4.703125 5.5625 -4.703125 5.609375 -4.6875 C 5.484375 -4.625 5.390625 -4.515625 5.390625 -4.375 C 5.390625 -4.25 5.46875 -4.125 5.609375 -4.109375 C 5.875 -4.109375 6 -4.28125 6 -4.5 C 6 -4.828125 5.6875 -4.921875 5.46875 -4.921875 C 5.078125 -4.921875 4.734375 -4.765625 4.421875 -4.53125 C 4.375 -4.515625 4.328125 -4.453125 4.28125 -4.453125 C 4.203125 -4.453125 4.03125 -4.609375 3.875 -4.671875 C 3.671875 -4.765625 3.421875 -4.8125 3.203125 -4.8125 L 3.0625 -4.8125 C 2.125 -4.75 1.171875 -4 1.171875 -2.984375 C 1.171875 -2.65625 1.28125 -2.359375 1.5 -2.125 Z M 4.40625 0.78125 C 4.3125 1.578125 3.1875 1.96875 2.390625 1.96875 C 1.859375 1.96875 0.703125 1.78125 0.703125 0.984375 L 0.703125 0.90625 C 0.8125 0.34375 1.296875 -0.09375 1.890625 -0.09375 L 2.84375 -0.09375 C 3.4375 -0.09375 4.421875 -0.0625 4.421875 0.6875 C 4.421875 0.71875 4.40625 0.75 4.40625 0.78125 Z M 3.9375 -3.65625 C 3.875 -2.9375 3.671875 -1.890625 2.6875 -1.890625 C 2.25 -1.890625 1.9375 -2.21875 1.9375 -2.765625 L 1.9375 -2.875 C 1.984375 -3.5625 2.25 -4.5625 3.15625 -4.5625 C 3.5625 -4.5625 3.9375 -4.296875 3.9375 -3.734375 Z M 3.9375 -3.65625 "
           id="path27" />
      </g>
      <g
         id="glyph-0-10">
        <path
           d="M 4.5625 -7.453125 L 4.515625 -7.125 L 4.65625 -7.125 C 4.96875 -7.125 5.265625 -7.109375 5.265625 -6.75 C 5.265625 -6.5625 5.21875 -6.375 5.1875 -6.1875 L 4.953125 -4.828125 C 4.921875 -4.59375 4.859375 -4.359375 4.84375 -4.109375 L 4.828125 -4.109375 C 4.640625 -4.578125 4.03125 -4.828125 3.546875 -4.828125 C 2.03125 -4.828125 0.734375 -3.40625 0.734375 -1.9375 C 0.734375 -0.78125 1.578125 0.09375 2.671875 0.09375 C 3.296875 0.09375 3.8125 -0.203125 4.21875 -0.609375 L 4.09375 0.09375 L 5.6875 -0.015625 L 5.75 -0.34375 L 5.578125 -0.34375 C 5.3125 -0.34375 4.984375 -0.375 4.984375 -0.6875 C 4.984375 -0.78125 5 -0.859375 5.015625 -0.9375 L 6.015625 -6.953125 C 6.0625 -7.171875 6.078125 -7.375 6.125 -7.578125 Z M 4.734375 -3.71875 C 4.734375 -3.609375 4.703125 -3.5 4.6875 -3.40625 L 4.34375 -1.3125 C 4.25 -0.734375 3.4375 -0.125 2.71875 -0.125 C 1.96875 -0.125 1.546875 -0.828125 1.546875 -1.578125 C 1.546875 -2.71875 2.09375 -4.578125 3.609375 -4.578125 C 4.0625 -4.578125 4.515625 -4.3125 4.6875 -3.859375 C 4.71875 -3.8125 4.734375 -3.765625 4.734375 -3.71875 Z M 4.734375 -3.71875 "
           id="path30" />
      </g>
      <g
         id="glyph-0-11">
        <path
           d="M 1.609375 -2.546875 L 4.78125 -2.546875 C 4.96875 -2.546875 5 -2.84375 5 -3.0625 L 5 -3.21875 C 5 -4.1875 4.390625 -4.859375 3.390625 -4.859375 C 1.890625 -4.859375 0.671875 -3.421875 0.671875 -2 C 0.671875 -1 1.28125 -0.046875 2.546875 0.09375 C 2.59375 0.09375 2.65625 0.109375 2.6875 0.109375 C 3.515625 0.109375 4.328125 -0.453125 4.671875 -1.171875 C 4.6875 -1.203125 4.71875 -1.265625 4.71875 -1.3125 C 4.71875 -1.390625 4.671875 -1.421875 4.609375 -1.421875 C 4.4375 -1.421875 4.359375 -1.140625 4.25 -1 C 3.9375 -0.546875 3.4375 -0.234375 2.875 -0.15625 L 2.796875 -0.15625 C 2.015625 -0.15625 1.515625 -0.84375 1.515625 -1.640625 C 1.515625 -1.9375 1.578125 -2.25 1.609375 -2.546875 Z M 4.25 -2.765625 L 1.65625 -2.765625 C 1.859375 -3.5625 2.359375 -4.625 3.34375 -4.625 C 3.8125 -4.625 4.3125 -4.28125 4.3125 -3.40625 C 4.3125 -3.203125 4.28125 -2.984375 4.25 -2.765625 Z M 4.25 -2.765625 "
           id="path33" />
      </g>
      <g
         id="glyph-0-12">
        <path
           d="M 1.734375 -7.453125 L 1.671875 -7.125 L 2.015625 -7.125 C 2.34375 -7.125 2.671875 -7.09375 2.671875 -6.84375 C 2.671875 -6.703125 2.625 -6.578125 2.625 -6.453125 L 1.75 -1.28125 C 1.71875 -1.09375 1.703125 -0.890625 1.59375 -0.734375 C 1.359375 -0.390625 0.921875 -0.34375 0.546875 -0.34375 L 0.5 -0.015625 L 2.90625 -0.015625 L 2.9375 -0.34375 C 2.578125 -0.34375 2 -0.40625 2 -0.90625 C 2 -0.984375 2.015625 -1.046875 2.03125 -1.109375 L 2.765625 -5.578125 C 2.859375 -6.0625 2.9375 -6.5625 3.015625 -7.0625 L 3.03125 -7.0625 C 3.046875 -6.875 3.109375 -6.671875 3.15625 -6.484375 C 3.5625 -4.453125 4.0625 -2.4375 4.484375 -0.40625 C 4.5 -0.28125 4.515625 -0.03125 4.671875 -0.015625 L 4.6875 -0.015625 C 4.859375 -0.015625 4.9375 -0.25 5 -0.375 C 6.140625 -2.390625 7.234375 -4.421875 8.359375 -6.453125 C 8.484375 -6.6875 8.625 -6.90625 8.734375 -7.140625 L 8.75 -7.140625 C 8.703125 -6.953125 8.6875 -6.765625 8.65625 -6.5625 L 7.734375 -1.078125 C 7.671875 -0.78125 7.703125 -0.40625 7.21875 -0.359375 C 7 -0.34375 6.765625 -0.34375 6.546875 -0.34375 L 6.515625 -0.015625 L 7.71875 -0.015625 L 7.96875 -0.046875 L 9.4375 -0.046875 L 9.484375 -0.34375 L 9.15625 -0.34375 C 8.8125 -0.34375 8.484375 -0.375 8.484375 -0.671875 C 8.484375 -0.78125 8.53125 -0.890625 8.546875 -1 L 9.4375 -6.3125 C 9.453125 -6.484375 9.46875 -6.6875 9.53125 -6.84375 C 9.640625 -7.109375 9.984375 -7.125 10.21875 -7.125 L 10.515625 -7.125 C 10.671875 -7.125 10.640625 -7.328125 10.671875 -7.453125 L 8.90625 -7.453125 L 8.703125 -7.421875 L 8.578125 -7.265625 L 5.140625 -1.046875 L 3.78125 -7.28125 L 3.703125 -7.421875 L 3.515625 -7.453125 Z M 1.734375 -7.453125 "
           id="path36" />
      </g>
      <g
         id="glyph-0-13">
        <path
           d="M 1.890625 -4.0625 C 2.1875 -4.40625 2.671875 -4.640625 3.140625 -4.640625 C 3.609375 -4.640625 4.09375 -4.328125 4.09375 -3.578125 C 4.09375 -3.375 4.09375 -2.84375 3.90625 -2.84375 C 2.90625 -2.84375 0.625 -2.515625 0.625 -0.796875 C 0.703125 -0.0625 1.671875 0.09375 2.171875 0.09375 C 2.78125 0.09375 3.484375 -0.265625 3.75 -0.828125 L 3.765625 -0.828125 C 3.75 -0.796875 3.75 -0.75 3.75 -0.71875 C 3.75 -0.34375 4 0.046875 4.453125 0.046875 C 5.328125 0.046875 5.546875 -0.859375 5.609375 -1.59375 L 5.34375 -1.59375 C 5.28125 -1.109375 5.21875 -0.28125 4.71875 -0.28125 C 4.453125 -0.28125 4.40625 -0.59375 4.40625 -0.75 C 4.40625 -0.96875 4.46875 -1.203125 4.515625 -1.421875 C 4.609375 -1.90625 4.671875 -2.40625 4.75 -2.890625 C 4.78125 -3.09375 4.84375 -3.3125 4.84375 -3.53125 L 4.84375 -3.625 C 4.796875 -4.453125 3.90625 -4.859375 3.1875 -4.859375 C 2.546875 -4.859375 1.890625 -4.59375 1.5625 -4.046875 C 1.46875 -3.890625 1.390625 -3.703125 1.390625 -3.53125 L 1.390625 -3.484375 C 1.40625 -3.25 1.609375 -3.125 1.8125 -3.125 C 2.09375 -3.125 2.328125 -3.390625 2.328125 -3.671875 C 2.328125 -3.890625 2.15625 -4.0625 1.890625 -4.0625 Z M 3.96875 -2.625 C 3.859375 -2.140625 3.859375 -1.59375 3.671875 -1.140625 C 3.453125 -0.609375 2.90625 -0.125 2.296875 -0.125 C 1.890625 -0.125 1.453125 -0.34375 1.453125 -0.875 C 1.453125 -1.140625 1.578125 -1.421875 1.71875 -1.640625 C 2.21875 -2.359375 3.140625 -2.578125 3.96875 -2.625 Z M 3.96875 -2.625 "
           id="path39" />
      </g>
      <g
         id="glyph-0-14">
        <path
           d="M 2.71875 -6.71875 C 2.6875 -5.984375 2 -4.609375 0.953125 -4.609375 L 0.921875 -4.375 L 1.859375 -4.375 C 1.828125 -4.09375 1.765625 -3.796875 1.71875 -3.515625 L 1.4375 -1.859375 C 1.390625 -1.59375 1.328125 -1.296875 1.328125 -1.015625 C 1.328125 -0.234375 1.890625 0.09375 2.53125 0.09375 C 3.40625 0.09375 3.765625 -0.84375 3.859375 -1.53125 C 3.890625 -1.6875 3.921875 -1.828125 3.9375 -1.984375 L 3.671875 -1.984375 C 3.59375 -1.34375 3.421875 -0.15625 2.609375 -0.15625 C 2.21875 -0.15625 2.046875 -0.546875 2.046875 -0.890625 C 2.046875 -1.03125 2.078125 -1.171875 2.09375 -1.28125 C 2.21875 -2 2.328125 -2.71875 2.4375 -3.421875 L 2.5625 -4.109375 C 2.578125 -4.25 2.5625 -4.375 2.703125 -4.375 L 4.15625 -4.375 L 4.203125 -4.703125 L 2.65625 -4.703125 L 2.984375 -6.71875 Z M 2.71875 -6.71875 "
           id="path42" />
      </g>
      <g
         id="glyph-0-15">
        <path
           d="M 1.609375 -7.453125 L 1.5625 -7.125 L 1.703125 -7.125 C 2 -7.125 2.328125 -7.109375 2.328125 -6.765625 C 2.328125 -6.609375 2.265625 -6.453125 2.25 -6.296875 L 1.390625 -1.15625 C 1.25 -0.40625 1.171875 -0.359375 0.6875 -0.34375 L 0.53125 -0.34375 C 0.375 -0.34375 0.390625 -0.140625 0.375 -0.015625 L 2.71875 -0.03125 L 2.765625 -0.109375 L 2.796875 -0.34375 L 2.5625 -0.34375 C 2.34375 -0.34375 2.015625 -0.34375 2.015625 -0.59375 C 2.015625 -0.65625 2.03125 -0.71875 2.046875 -0.78125 L 3.078125 -7.015625 C 3.109375 -7.203125 3.125 -7.390625 3.171875 -7.578125 Z M 1.609375 -7.453125 "
           id="path45" />
      </g>
      <g
         id="glyph-0-16">
        <path
           d="M 1.140625 -4.6875 L 1.078125 -4.359375 L 1.25 -4.359375 C 1.53125 -4.359375 1.84375 -4.328125 1.84375 -4.03125 C 1.84375 -3.96875 1.828125 -3.921875 1.828125 -3.859375 L 1.3125 -0.8125 C 1.25 -0.4375 1.140625 -0.34375 0.40625 -0.34375 L 0.359375 -0.015625 L 2.765625 -0.015625 L 2.8125 -0.34375 L 2.578125 -0.34375 C 2.3125 -0.34375 2.046875 -0.359375 2.046875 -0.609375 C 2.046875 -0.6875 2.0625 -0.765625 2.078125 -0.84375 L 2.359375 -2.578125 C 2.5 -3.40625 2.765625 -4.0625 3.625 -4.46875 C 3.8125 -4.53125 4 -4.578125 4.203125 -4.578125 C 4.59375 -4.578125 4.8125 -4.28125 4.8125 -3.859375 C 4.8125 -3.703125 4.78125 -3.53125 4.75 -3.375 C 4.640625 -2.65625 4.53125 -1.96875 4.40625 -1.25 L 4.328125 -0.78125 C 4.25 -0.421875 4.109375 -0.34375 3.40625 -0.34375 L 3.375 -0.015625 L 5.78125 -0.015625 L 5.828125 -0.34375 L 5.578125 -0.34375 C 5.328125 -0.34375 5.046875 -0.359375 5.046875 -0.609375 C 5.046875 -0.6875 5.078125 -0.765625 5.078125 -0.84375 L 5.359375 -2.578125 C 5.5 -3.40625 5.78125 -4.0625 6.640625 -4.46875 C 6.8125 -4.53125 7.015625 -4.578125 7.203125 -4.578125 C 7.609375 -4.578125 7.8125 -4.28125 7.8125 -3.859375 C 7.8125 -3.703125 7.796875 -3.53125 7.765625 -3.375 C 7.65625 -2.65625 7.53125 -1.96875 7.421875 -1.25 L 7.34375 -0.78125 C 7.265625 -0.421875 7.125 -0.34375 6.421875 -0.34375 L 6.375 -0.015625 L 8.796875 -0.015625 L 8.828125 -0.34375 L 8.65625 -0.34375 C 8.4375 -0.34375 8.078125 -0.34375 8.0625 -0.578125 L 8.0625 -0.625 C 8.0625 -0.703125 8.078125 -0.78125 8.09375 -0.875 L 8.46875 -3.046875 C 8.5 -3.265625 8.546875 -3.515625 8.546875 -3.734375 C 8.546875 -4.609375 7.875 -4.8125 7.203125 -4.8125 C 6.546875 -4.8125 5.796875 -4.3125 5.546875 -3.765625 L 5.53125 -3.765625 C 5.53125 -4.546875 4.90625 -4.8125 4.3125 -4.8125 C 3.59375 -4.8125 2.828125 -4.40625 2.515625 -3.734375 L 2.5 -3.734375 L 2.671875 -4.8125 Z M 1.140625 -4.6875 "
           id="path48" />
      </g>
      <g
         id="glyph-0-17">
        <path
           d="M 3.359375 -4.859375 C 1.890625 -4.71875 0.671875 -3.40625 0.671875 -1.9375 C 0.671875 -0.890625 1.390625 0.09375 2.703125 0.09375 C 4.21875 0.09375 5.5 -1.28125 5.5 -2.765625 C 5.5 -3.71875 4.921875 -4.859375 3.5 -4.859375 Z M 4.703125 -3.09375 C 4.625 -2.1875 4.5 -1.109375 3.71875 -0.53125 C 3.4375 -0.3125 3.078125 -0.171875 2.71875 -0.171875 C 2 -0.171875 1.5 -0.734375 1.5 -1.59375 L 1.5 -1.75 C 1.609375 -2.84375 1.921875 -4.640625 3.484375 -4.640625 C 4.171875 -4.640625 4.71875 -4.09375 4.71875 -3.296875 C 4.71875 -3.234375 4.71875 -3.15625 4.703125 -3.09375 Z M 4.703125 -3.09375 "
           id="path51" />
      </g>
      <g
         id="glyph-0-18">
        <path
           d="M 0.5 -3.015625 L 0.46875 -2.796875 L 5.875 -2.796875 L 5.90625 -3.015625 Z M 0.5 -3.015625 "
           id="path54" />
      </g>
      <g
         id="glyph-0-19">
        <path
           d="M 1.6875 -7.453125 L 1.640625 -7.125 C 1.75 -7.125 1.890625 -7.140625 2 -7.140625 C 2.328125 -7.140625 2.625 -7.09375 2.625 -6.8125 C 2.625 -6.703125 2.59375 -6.59375 2.578125 -6.5 L 2.046875 -3.234375 C 1.984375 -2.90625 1.90625 -2.578125 1.890625 -2.25 L 1.890625 -2.09375 C 1.890625 -1.015625 2.5625 0.21875 4.203125 0.21875 L 4.3125 0.21875 C 5.609375 0.125 6.640625 -0.96875 6.953125 -2.171875 C 7.046875 -2.515625 7.09375 -2.875 7.15625 -3.234375 L 7.625 -6.109375 C 7.75 -6.8125 8 -7.125 8.71875 -7.125 L 8.75 -7.125 C 8.890625 -7.125 8.875 -7.328125 8.90625 -7.453125 L 6.484375 -7.421875 L 6.4375 -7.125 C 6.8125 -7.125 7.390625 -7.078125 7.390625 -6.546875 C 7.390625 -6.421875 7.34375 -6.296875 7.328125 -6.1875 L 6.84375 -3.21875 C 6.765625 -2.828125 6.734375 -2.4375 6.609375 -2.0625 C 6.265625 -1.0625 5.359375 -0.109375 4.234375 -0.109375 C 3.453125 -0.109375 2.75 -0.671875 2.75 -1.75 C 2.75 -2.125 2.828125 -2.5 2.890625 -2.859375 L 3.484375 -6.421875 C 3.515625 -6.59375 3.515625 -6.8125 3.625 -6.953125 C 3.765625 -7.125 4.078125 -7.125 4.28125 -7.125 L 4.53125 -7.125 C 4.703125 -7.125 4.671875 -7.328125 4.703125 -7.453125 L 2.3125 -7.4375 Z M 6.578125 -9.421875 C 6.296875 -9.390625 6.046875 -9.140625 6.046875 -8.828125 C 6.046875 -8.546875 6.25 -8.34375 6.5 -8.34375 C 6.84375 -8.34375 7.109375 -8.609375 7.140625 -8.9375 L 7.140625 -8.96875 C 7.140625 -9.234375 6.921875 -9.4375 6.65625 -9.4375 C 6.625 -9.4375 6.609375 -9.421875 6.578125 -9.421875 Z M 4.484375 -9.421875 C 4.1875 -9.390625 3.9375 -9.140625 3.9375 -8.828125 C 3.9375 -8.5625 4.140625 -8.34375 4.40625 -8.34375 C 4.734375 -8.34375 5.03125 -8.625 5.03125 -8.96875 C 5.03125 -9.234375 4.828125 -9.4375 4.5625 -9.4375 C 4.53125 -9.4375 4.515625 -9.421875 4.484375 -9.421875 Z M 4.484375 -9.421875 "
           id="path57" />
      </g>
      <g
         id="glyph-0-20">
        <path
           d="M 1.546875 -7.453125 L 1.5 -7.125 L 1.671875 -7.125 C 1.9375 -7.125 2.25 -7.09375 2.25 -6.796875 C 2.25 -6.703125 2.25 -6.609375 2.21875 -6.53125 L 1.453125 -1.875 C 1.359375 -1.25 1.234375 -0.625 1.140625 -0.015625 L 1.40625 -0.03125 L 1.9375 -0.703125 C 2.109375 -0.15625 2.75 0.09375 3.265625 0.09375 C 4.75 0.09375 6.0625 -1.3125 6.0625 -2.78125 C 6.0625 -3.734375 5.40625 -4.8125 4.140625 -4.8125 C 3.515625 -4.8125 2.96875 -4.53125 2.546875 -4.109375 L 3.125 -7.578125 Z M 5.21875 -2.984375 C 5.140625 -2.078125 5 -0.953125 4.03125 -0.375 C 3.78125 -0.234375 3.484375 -0.125 3.1875 -0.125 C 2.828125 -0.125 2.4375 -0.3125 2.25 -0.625 C 2.171875 -0.734375 2.078125 -0.921875 2.078125 -1.0625 L 2.078125 -1.09375 C 2.078125 -1.265625 2.125 -1.4375 2.15625 -1.609375 L 2.4375 -3.296875 C 2.5 -4 3.3125 -4.578125 4.0625 -4.578125 C 4.671875 -4.578125 5.234375 -4.078125 5.234375 -3.203125 C 5.234375 -3.125 5.234375 -3.046875 5.21875 -2.984375 Z M 5.21875 -2.984375 "
           id="path60" />
      </g>
      <g
         id="glyph-0-21">
        <path
           d="M 1.015625 -0.40625 L 1.03125 -0.40625 C 1.28125 -0.015625 1.734375 0.09375 2.171875 0.09375 C 3.046875 0.09375 4.15625 -0.390625 4.15625 -1.609375 L 4.15625 -1.671875 C 4.140625 -2.140625 3.84375 -2.515625 3.453125 -2.71875 C 2.875 -3.03125 1.484375 -2.875 1.484375 -3.71875 C 1.484375 -4.421875 2.375 -4.671875 2.890625 -4.671875 C 3.453125 -4.671875 3.953125 -4.359375 3.953125 -3.671875 C 3.953125 -3.59375 3.953125 -3.53125 3.9375 -3.46875 L 3.9375 -3.34375 C 3.953125 -3.28125 4.015625 -3.25 4.0625 -3.25 C 4.234375 -3.25 4.21875 -3.546875 4.25 -3.703125 L 4.390625 -4.53125 C 4.390625 -4.578125 4.421875 -4.671875 4.421875 -4.734375 C 4.421875 -4.796875 4.375 -4.859375 4.3125 -4.859375 C 4.234375 -4.859375 4.140625 -4.78125 4.09375 -4.734375 L 4.046875 -4.6875 C 3.984375 -4.640625 3.921875 -4.59375 3.875 -4.53125 C 3.546875 -4.78125 3.28125 -4.859375 2.90625 -4.859375 C 2.078125 -4.859375 0.9375 -4.515625 0.9375 -3.359375 L 0.9375 -3.265625 C 1.046875 -2.3125 2.125 -2.25 2.796875 -2.09375 C 3.171875 -2.015625 3.5625 -1.765625 3.59375 -1.359375 L 3.59375 -1.28125 C 3.59375 -0.484375 2.828125 -0.125 2.125 -0.125 C 1.328125 -0.125 0.921875 -0.78125 0.921875 -1.6875 C 0.921875 -1.78125 0.90625 -1.875 0.78125 -1.875 C 0.59375 -1.875 0.609375 -1.5 0.578125 -1.3125 L 0.40625 -0.265625 C 0.390625 -0.21875 0.359375 -0.125 0.359375 -0.046875 C 0.359375 0.03125 0.390625 0.09375 0.46875 0.09375 C 0.609375 0.09375 0.71875 -0.09375 0.8125 -0.1875 C 0.875 -0.265625 0.953125 -0.328125 1.015625 -0.40625 Z M 1.015625 -0.40625 "
           id="path63" />
      </g>
      <g
         id="glyph-0-22">
        <path
           d="M 7.125 -8.421875 C 6.875 -8.390625 6.640625 -8.375 6.390625 -8.328125 C 3.375 -7.703125 0.96875 -4.890625 0.96875 -1.796875 C 0.96875 0.453125 2.4375 2.9375 5.578125 2.9375 C 9.015625 2.9375 11.96875 -0.34375 11.96875 -3.671875 C 11.96875 -5.65625 10.890625 -7.78125 8.359375 -8.328125 C 8.046875 -8.390625 7.703125 -8.4375 7.390625 -8.4375 C 7.296875 -8.4375 7.21875 -8.4375 7.125 -8.421875 Z M 11.53125 -3.453125 C 11.359375 -0.421875 8.765625 2.515625 5.546875 2.515625 C 3.5625 2.515625 1.390625 1.125 1.390625 -1.78125 C 1.390625 -4.90625 4.140625 -8 7.375 -8 C 9.59375 -8 11.53125 -6.3125 11.53125 -3.734375 C 11.53125 -3.640625 11.53125 -3.546875 11.53125 -3.453125 Z M 6.8125 -5.453125 C 5.140625 -5.265625 3.40625 -4.078125 3.40625 -2.21875 C 3.40625 -0.671875 4.734375 0.21875 6.046875 0.21875 C 7.234375 0.21875 8.453125 -0.546875 8.703125 -1.734375 C 8.71875 -1.765625 8.71875 -1.796875 8.71875 -1.84375 C 8.71875 -1.90625 8.65625 -1.96875 8.59375 -1.96875 C 8.421875 -1.96875 8.40625 -1.609375 8.359375 -1.484375 C 8.015625 -0.65625 7.125 -0.109375 6.234375 -0.109375 C 5.25 -0.109375 4.421875 -0.765625 4.421875 -1.90625 C 4.421875 -3.34375 5.109375 -4.765625 6.65625 -5.078125 C 6.8125 -5.109375 6.953125 -5.125 7.109375 -5.125 C 8.0625 -5.125 8.65625 -4.328125 8.65625 -3.453125 L 8.65625 -3.359375 C 8.65625 -3.265625 8.6875 -3.171875 8.796875 -3.171875 C 9.015625 -3.171875 9 -3.453125 9.015625 -3.59375 L 9.234375 -4.921875 C 9.265625 -5.046875 9.28125 -5.15625 9.296875 -5.28125 L 9.296875 -5.328125 C 9.296875 -5.375 9.296875 -5.453125 9.203125 -5.453125 C 8.984375 -5.453125 8.609375 -4.859375 8.46875 -4.859375 C 8.40625 -4.859375 8.15625 -5.109375 7.984375 -5.21875 C 7.671875 -5.375 7.34375 -5.46875 7 -5.46875 C 6.953125 -5.46875 6.875 -5.453125 6.8125 -5.453125 Z M 6.8125 -5.453125 "
           id="path66" />
      </g>
      <g
         id="glyph-0-23">
        <path
           d="M 1.703125 -7.453125 L 1.640625 -7.125 L 1.984375 -7.125 C 2.328125 -7.125 2.65625 -7.09375 2.65625 -6.8125 C 2.65625 -6.703125 2.609375 -6.59375 2.59375 -6.484375 L 1.671875 -1.015625 C 1.578125 -0.453125 1.546875 -0.34375 0.515625 -0.34375 L 0.46875 -0.015625 L 1.71875 -0.015625 L 1.96875 -0.046875 L 3.484375 -0.046875 L 3.515625 -0.34375 C 3.40625 -0.34375 3.28125 -0.328125 3.15625 -0.328125 C 2.828125 -0.328125 2.546875 -0.375 2.546875 -0.640625 C 2.546875 -0.6875 2.546875 -0.71875 2.546875 -0.765625 L 2.625 -1.265625 C 2.765625 -2 2.890625 -2.71875 3 -3.46875 L 4.671875 -3.46875 C 6.078125 -3.46875 7.6875 -4.28125 7.6875 -5.703125 C 7.6875 -6.734375 6.6875 -7.40625 5.59375 -7.453125 Z M 3.015625 -3.734375 C 3.0625 -4.015625 3.109375 -4.28125 3.15625 -4.5625 L 3.5 -6.703125 C 3.5625 -6.984375 3.578125 -7.125 4.140625 -7.125 L 4.421875 -7.125 C 4.609375 -7.125 4.78125 -7.140625 4.96875 -7.140625 C 5.703125 -7.140625 6.6875 -7 6.6875 -5.9375 C 6.6875 -5.25 6.4375 -4.4375 5.875 -4.09375 C 5.40625 -3.78125 4.84375 -3.734375 4.28125 -3.734375 Z M 3.015625 -3.734375 "
           id="path69" />
      </g>
      <g
         id="glyph-0-24">
        <path
           d="M 1.59375 -1.09375 C 1.296875 -1.0625 1.046875 -0.796875 1.046875 -0.484375 C 1.046875 -0.234375 1.25 -0.015625 1.515625 -0.015625 C 1.84375 -0.015625 2.15625 -0.28125 2.15625 -0.625 C 2.15625 -0.890625 1.9375 -1.09375 1.671875 -1.09375 C 1.640625 -1.09375 1.625 -1.09375 1.59375 -1.09375 Z M 1.59375 -1.09375 "
           id="path72" />
      </g>
      <g
         id="glyph-0-25">
        <path
           d="M 1.703125 -7.453125 L 1.640625 -7.125 L 1.984375 -7.125 C 2.328125 -7.125 2.65625 -7.09375 2.65625 -6.8125 C 2.65625 -6.703125 2.609375 -6.59375 2.59375 -6.484375 L 1.671875 -1.015625 C 1.625 -0.671875 1.578125 -0.390625 1.171875 -0.359375 C 0.953125 -0.34375 0.734375 -0.34375 0.515625 -0.34375 L 0.46875 -0.015625 L 4.109375 -0.015625 C 4.859375 -0.015625 5.40625 -0.125 6 -0.453125 C 7.421875 -1.203125 8.328125 -2.796875 8.328125 -4.390625 C 8.328125 -5.875 7.5 -7.46875 5.40625 -7.46875 C 5.203125 -7.46875 5 -7.453125 4.78125 -7.453125 Z M 7.359375 -4.5 C 7.203125 -2.71875 6.6875 -0.34375 3.90625 -0.34375 L 2.9375 -0.34375 C 2.734375 -0.34375 2.484375 -0.34375 2.484375 -0.5625 C 2.484375 -0.625 2.515625 -0.703125 2.515625 -0.765625 L 3.484375 -6.53125 C 3.515625 -6.859375 3.515625 -7.125 4.015625 -7.125 L 5.109375 -7.125 C 5.625 -7.125 6.125 -7.046875 6.546875 -6.734375 C 7.15625 -6.28125 7.375 -5.546875 7.375 -4.828125 C 7.375 -4.71875 7.375 -4.609375 7.359375 -4.5 Z M 7.359375 -4.5 "
           id="path75" />
      </g>
      <g
         id="glyph-0-26">
        <path
           d="M 1.71875 -7.453125 L 1.65625 -7.125 L 2 -7.125 C 2.328125 -7.125 2.65625 -7.09375 2.65625 -6.8125 C 2.65625 -6.703125 2.625 -6.59375 2.609375 -6.484375 L 1.6875 -1.015625 C 1.640625 -0.671875 1.59375 -0.390625 1.1875 -0.359375 C 0.96875 -0.34375 0.734375 -0.34375 0.53125 -0.34375 L 0.484375 -0.015625 L 3.765625 -0.015625 C 3.984375 -0.015625 4.21875 0 4.453125 0 C 5.734375 0 7.1875 -0.671875 7.40625 -2.015625 C 7.421875 -2.09375 7.421875 -2.171875 7.421875 -2.25 C 7.421875 -3.171875 6.484375 -3.890625 5.609375 -3.890625 L 5.609375 -3.921875 C 6.296875 -3.953125 7.390625 -4.578125 7.640625 -5.421875 C 7.703125 -5.578125 7.703125 -5.765625 7.703125 -5.9375 C 7.703125 -7.078125 6.3125 -7.46875 5.46875 -7.46875 C 5.265625 -7.46875 5.078125 -7.453125 4.890625 -7.453125 Z M 6.40625 -2.265625 C 6.34375 -1.09375 5.375 -0.34375 4.25 -0.34375 L 2.828125 -0.34375 C 2.65625 -0.34375 2.46875 -0.375 2.46875 -0.5625 L 2.46875 -0.578125 C 2.484375 -0.671875 2.515625 -0.765625 2.515625 -0.859375 L 2.96875 -3.546875 C 2.984375 -3.640625 2.96875 -3.78125 3.125 -3.78125 L 5.015625 -3.78125 C 5.625 -3.78125 6.140625 -3.515625 6.375 -2.765625 C 6.390625 -2.640625 6.421875 -2.515625 6.421875 -2.375 C 6.421875 -2.34375 6.40625 -2.296875 6.40625 -2.265625 Z M 3.046875 -4 C 3.09375 -4.25 3.125 -4.5 3.171875 -4.75 L 3.5 -6.703125 C 3.53125 -7 3.625 -7.140625 4.125 -7.140625 C 4.25 -7.140625 4.359375 -7.125 4.484375 -7.125 L 5.4375 -7.125 C 6.03125 -7.125 6.734375 -6.8125 6.734375 -5.875 C 6.734375 -5.015625 6.03125 -4.3125 5.25 -4.078125 C 5.015625 -4.015625 4.765625 -4 4.515625 -4 Z M 3.046875 -4 "
           id="path78" />
      </g>
      <g
         id="glyph-0-27">
        <path
           d="M 0.9375 -2.953125 L 1.109375 -2.953125 C 1.296875 -2.953125 1.34375 -3.921875 1.859375 -4.25 C 2.1875 -4.453125 2.625 -4.46875 3.015625 -4.46875 L 4.21875 -4.46875 C 2.96875 -3.15625 1.71875 -1.796875 0.53125 -0.421875 C 0.453125 -0.34375 0.328125 -0.265625 0.328125 -0.140625 C 0.328125 -0.046875 0.375 -0.015625 0.46875 -0.015625 L 3.953125 -0.015625 C 3.984375 -0.015625 4.03125 0 4.0625 0 C 4.28125 0 4.421875 -0.953125 4.53125 -1.390625 C 4.59375 -1.609375 4.65625 -1.828125 4.703125 -2.046875 L 4.53125 -2.046875 C 4.390625 -2.046875 4.328125 -1.65625 4.28125 -1.5 C 4.171875 -1.140625 4.015625 -0.78125 3.703125 -0.5625 C 3.34375 -0.296875 2.875 -0.265625 2.4375 -0.265625 L 1.203125 -0.265625 C 2.21875 -1.359375 3.203125 -2.4375 4.1875 -3.53125 L 4.890625 -4.3125 C 4.96875 -4.375 5.09375 -4.484375 5.09375 -4.59375 C 5.09375 -4.671875 5.03125 -4.703125 4.953125 -4.703125 L 1.46875 -4.703125 C 1.28125 -4.703125 1.28125 -4.421875 1.25 -4.25 C 1.140625 -3.8125 1.03125 -3.375 0.9375 -2.953125 Z M 0.9375 -2.953125 "
           id="path81" />
      </g>
      <g
         id="glyph-1-0" />
      <g
         id="glyph-1-1">
        <path
           d="M 0.484375 -8.21875 L 0.484375 -7.703125 L 1.75 -7.703125 L 1.75 -0.75 C 1.75 -0.546875 1.28125 -0.53125 0.875 -0.53125 L 0.484375 -0.53125 L 0.484375 -0.015625 L 3.59375 -0.015625 L 3.59375 -0.53125 L 3.125 -0.53125 C 2.71875 -0.53125 2.328125 -0.546875 2.328125 -0.75 L 2.34375 -7.546875 C 2.359375 -7.453125 2.421875 -7.375 2.453125 -7.296875 L 2.625 -6.890625 C 3.4375 -5.1875 4.171875 -3.4375 4.921875 -1.734375 L 5.515625 -0.421875 C 5.609375 -0.21875 5.671875 -0.015625 5.953125 -0.015625 C 6.1875 -0.03125 6.265625 -0.25 6.34375 -0.4375 L 6.953125 -1.8125 C 7.546875 -3.125 8.125 -4.453125 8.71875 -5.765625 L 9.28125 -7.015625 C 9.375 -7.234375 9.484375 -7.453125 9.5625 -7.6875 L 9.578125 -0.53125 L 8.3125 -0.53125 L 8.3125 -0.015625 L 12.25 -0.015625 L 12.25 -0.53125 L 10.984375 -0.53125 L 10.984375 -7.703125 L 12.25 -7.703125 L 12.25 -8.21875 L 9.59375 -8.21875 C 9.390625 -8.21875 9.296875 -8.109375 9.234375 -7.9375 L 9.09375 -7.65625 C 8.3125 -5.796875 7.421875 -3.96875 6.640625 -2.109375 C 6.546875 -1.921875 6.4375 -1.734375 6.390625 -1.546875 L 6.359375 -1.546875 C 6.203125 -2.046875 5.890625 -2.609375 5.65625 -3.125 C 5 -4.640625 4.296875 -6.140625 3.640625 -7.65625 L 3.515625 -7.9375 C 3.4375 -8.109375 3.34375 -8.21875 3.140625 -8.21875 Z M 0.484375 -8.21875 "
           id="path85" />
      </g>
      <g
         id="glyph-1-2">
        <path
           d="M 1.984375 -4.921875 L 1.984375 -4.9375 C 2.265625 -5 2.578125 -5.03125 2.875 -5.03125 C 3.59375 -5.03125 4.203125 -4.671875 4.203125 -3.515625 L 4.203125 -3.125 C 2.734375 -3.125 0.390625 -2.78125 0.390625 -1.265625 C 0.390625 -0.203125 1.734375 0.0625 2.671875 0.0625 L 2.796875 0.0625 C 3.421875 0.03125 4.140625 -0.359375 4.34375 -0.9375 C 4.390625 -0.78125 4.34375 -0.609375 4.421875 -0.4375 C 4.65625 -0.046875 5.171875 -0.015625 5.59375 -0.015625 L 6.328125 -0.015625 C 6.484375 -0.015625 6.53125 -0.125 6.53125 -0.28125 C 6.53125 -0.4375 6.46875 -0.53125 6.28125 -0.53125 L 6.1875 -0.53125 C 5.921875 -0.546875 5.515625 -0.578125 5.5 -0.84375 L 5.5 -3.484375 C 5.5 -4.21875 5.203125 -4.765625 4.53125 -5.109375 C 4.03125 -5.359375 3.484375 -5.421875 2.921875 -5.421875 C 2.234375 -5.421875 0.859375 -5.390625 0.859375 -4.34375 C 0.859375 -4.03125 1.078125 -3.703125 1.46875 -3.640625 L 1.546875 -3.640625 C 1.921875 -3.640625 2.265625 -3.90625 2.265625 -4.34375 C 2.265625 -4.578125 2.171875 -4.8125 1.984375 -4.921875 Z M 4.203125 -2.796875 L 4.203125 -1.703125 C 4.203125 -0.890625 3.578125 -0.328125 2.828125 -0.328125 C 2.296875 -0.328125 1.734375 -0.6875 1.734375 -1.28125 C 1.734375 -2.3125 2.96875 -2.671875 3.75 -2.765625 C 3.890625 -2.765625 4.046875 -2.765625 4.203125 -2.796875 Z M 4.203125 -2.796875 "
           id="path88" />
      </g>
      <g
         id="glyph-1-3">
        <path
           d="M 0.28125 -5.3125 L 0.28125 -4.8125 L 0.84375 -4.8125 C 0.890625 -4.8125 0.9375 -4.8125 0.984375 -4.8125 C 1.109375 -4.8125 1.171875 -4.75 1.234375 -4.65625 L 1.46875 -4.375 C 1.90625 -3.84375 2.34375 -3.28125 2.796875 -2.765625 C 2.84375 -2.703125 2.9375 -2.625 2.9375 -2.546875 L 2.9375 -2.53125 C 2.9375 -2.46875 2.84375 -2.390625 2.796875 -2.34375 L 1.625 -1 C 1.4375 -0.78125 1.34375 -0.609375 0.9375 -0.5625 C 0.703125 -0.53125 0.453125 -0.53125 0.21875 -0.53125 L 0.21875 -0.015625 L 2.515625 -0.015625 L 2.515625 -0.53125 L 2.171875 -0.578125 L 2.0625 -0.65625 L 2.359375 -1.046875 L 3.328125 -2.140625 L 4.640625 -0.53125 L 4.140625 -0.53125 L 4.140625 -0.015625 L 6.890625 -0.015625 L 6.890625 -0.53125 L 6.328125 -0.53125 C 6.28125 -0.53125 6.21875 -0.515625 6.171875 -0.515625 C 6.03125 -0.515625 6 -0.59375 5.921875 -0.6875 L 5.671875 -0.984375 C 5.171875 -1.5625 4.703125 -2.15625 4.234375 -2.734375 C 4.1875 -2.796875 4.078125 -2.875 4.078125 -2.96875 C 4.078125 -3.078125 4.453125 -3.421875 4.625 -3.640625 L 5.265625 -4.34375 C 5.546875 -4.671875 5.671875 -4.8125 6.640625 -4.8125 L 6.640625 -5.3125 L 4.34375 -5.3125 L 4.34375 -4.8125 L 4.703125 -4.75 L 4.8125 -4.671875 L 4.75 -4.546875 L 3.6875 -3.375 L 2.515625 -4.8125 L 3.03125 -4.8125 L 3.03125 -5.3125 Z M 0.28125 -5.3125 "
           id="path91" />
      </g>
      <g
         id="glyph-1-4">
        <path
           d="M 0.28125 -5.3125 L 0.28125 -4.8125 L 0.984375 -4.8125 C 1.015625 -4.65625 1.09375 -4.515625 1.140625 -4.375 C 1.640625 -2.984375 2.265625 -1.640625 2.796875 -0.265625 C 2.875 -0.09375 2.921875 0.0625 3.1875 0.0625 C 3.59375 0.0625 3.640625 -0.375 3.765625 -0.65625 C 4.078125 -1.4375 4.40625 -2.234375 4.703125 -3.03125 C 4.75 -3.125 4.8125 -3.234375 4.84375 -3.359375 L 4.859375 -3.359375 C 4.890625 -3.171875 4.984375 -3.015625 5.0625 -2.84375 C 5.359375 -2.015625 5.6875 -1.1875 6.046875 -0.375 C 6.140625 -0.109375 6.21875 0.046875 6.515625 0.046875 C 6.796875 0.046875 6.84375 -0.125 6.921875 -0.328125 C 7.015625 -0.578125 7.125 -0.8125 7.21875 -1.0625 L 8.546875 -4.359375 C 8.671875 -4.703125 8.78125 -4.8125 9.421875 -4.8125 L 9.421875 -5.3125 L 7.40625 -5.3125 L 7.40625 -4.8125 C 7.609375 -4.8125 8.03125 -4.796875 8.078125 -4.671875 L 8.078125 -4.640625 C 8.078125 -4.5625 8.046875 -4.484375 8.015625 -4.4375 L 7.765625 -3.828125 C 7.453125 -3.03125 7.09375 -2.21875 6.796875 -1.40625 L 5.4375 -4.8125 L 6.109375 -4.8125 L 6.109375 -5.3125 L 3.5625 -5.3125 L 3.5625 -4.8125 L 4.25 -4.8125 L 4.5 -4.21875 L 4.546875 -4 L 3.609375 -1.640625 L 2.3125 -4.8125 L 3 -4.8125 L 3 -5.3125 Z M 0.28125 -5.3125 "
           id="path94" />
      </g>
      <g
         id="glyph-1-5">
        <path
           d="M 1.8125 -2.65625 L 5.515625 -2.65625 C 5.671875 -2.65625 5.75 -2.75 5.75 -2.90625 C 5.75 -4.1875 5.140625 -5.421875 3.234375 -5.421875 C 2.546875 -5.421875 1.859375 -5.234375 1.3125 -4.8125 C 0.6875 -4.3125 0.375 -3.5 0.375 -2.703125 C 0.375 -0.984375 1.703125 0.0625 3.453125 0.0625 C 4.359375 0.0625 5.359375 -0.359375 5.71875 -1.28125 C 5.734375 -1.3125 5.75 -1.359375 5.75 -1.40625 C 5.75 -1.53125 5.640625 -1.609375 5.484375 -1.609375 C 5.21875 -1.609375 5.21875 -1.328125 5.0625 -1.109375 C 4.734375 -0.625 4.140625 -0.375 3.546875 -0.375 C 2.96875 -0.375 2.40625 -0.609375 2.109375 -1.125 C 1.84375 -1.578125 1.8125 -2.140625 1.8125 -2.65625 Z M 1.8125 -3.015625 C 1.8125 -3.953125 2.15625 -5.03125 3.265625 -5.03125 C 4.125 -5.03125 4.515625 -4.265625 4.609375 -3.515625 C 4.609375 -3.34375 4.609375 -3.171875 4.640625 -3.015625 Z M 1.8125 -3.015625 "
           id="path97" />
      </g>
      <g
         id="glyph-1-6">
        <path
           d="M 0.53125 -8.21875 L 0.53125 -7.703125 L 0.828125 -7.703125 C 1.09375 -7.703125 1.34375 -7.65625 1.34375 -7.3125 L 1.34375 -0.53125 L 0.53125 -0.53125 L 0.53125 -0.015625 L 3.421875 -0.015625 L 3.421875 -0.53125 L 2.59375 -0.53125 L 2.59375 -8.3125 L 1.21875 -8.3125 Z M 0.53125 -8.21875 "
           id="path100" />
      </g>
      <g
         id="glyph-1-7">
        <path
           d="M 0 -3.484375 L 0 -3.09375 L 6.703125 -3.09375 L 6.703125 -3.484375 Z M 0 -3.484375 "
           id="path103" />
      </g>
      <g
         id="glyph-1-8">
        <path
           d="M 3.125 -5.421875 C 2.234375 -5.328125 1.390625 -5.0625 0.828125 -4.25 C 0.53125 -3.78125 0.375 -3.21875 0.375 -2.640625 C 0.375 -1.953125 0.59375 -1.25 1.09375 -0.75 C 1.671875 -0.171875 2.515625 0.0625 3.34375 0.0625 C 4.15625 0.0625 5.046875 -0.171875 5.625 -0.765625 C 6.125 -1.25 6.328125 -1.953125 6.328125 -2.625 C 6.328125 -3.34375 6.078125 -4.078125 5.609375 -4.59375 C 5.015625 -5.21875 4.109375 -5.421875 3.28125 -5.421875 Z M 1.8125 -2.265625 L 1.8125 -2.96875 C 1.8125 -3.53125 1.828125 -4.203125 2.265625 -4.625 C 2.53125 -4.90625 2.953125 -5.03125 3.359375 -5.03125 C 4.265625 -5.03125 4.78125 -4.4375 4.859375 -3.578125 C 4.890625 -3.34375 4.90625 -3.109375 4.90625 -2.875 L 4.90625 -2.515625 C 4.90625 -1.96875 4.859375 -1.3125 4.53125 -0.890625 C 4.25 -0.53125 3.796875 -0.375 3.359375 -0.375 C 2.890625 -0.375 2.421875 -0.546875 2.15625 -0.921875 C 1.859375 -1.3125 1.859375 -1.8125 1.8125 -2.265625 Z M 1.8125 -2.265625 "
           id="path106" />
      </g>
      <g
         id="glyph-1-9">
        <path
           d="M 4.140625 -8.21875 L 4.140625 -7.703125 C 4.25 -7.703125 4.34375 -7.703125 4.453125 -7.703125 C 4.703125 -7.703125 4.96875 -7.65625 4.96875 -7.296875 L 4.96875 -4.828125 C 4.515625 -5.1875 3.96875 -5.390625 3.375 -5.390625 C 1.859375 -5.390625 0.4375 -4.46875 0.4375 -2.65625 C 0.4375 -1.203125 1.421875 0.0625 3.15625 0.0625 C 3.796875 0.0625 4.40625 -0.125 4.90625 -0.546875 L 4.90625 0.0625 L 6.453125 0.0625 L 7.046875 -0.015625 L 7.046875 -0.53125 C 6.9375 -0.53125 6.84375 -0.515625 6.734375 -0.515625 C 6.453125 -0.515625 6.21875 -0.578125 6.21875 -0.9375 L 6.21875 -8.3125 L 4.59375 -8.234375 Z M 1.890625 -2.1875 L 1.890625 -2.78125 C 1.890625 -3.46875 1.9375 -4.265625 2.546875 -4.703125 C 2.828125 -4.90625 3.15625 -5 3.484375 -5 C 4 -5 4.5 -4.765625 4.8125 -4.375 C 4.859375 -4.328125 4.90625 -4.265625 4.90625 -4.203125 L 4.90625 -1.375 C 4.90625 -1.296875 4.90625 -1.234375 4.859375 -1.15625 C 4.546875 -0.671875 3.9375 -0.328125 3.34375 -0.328125 C 2.484375 -0.328125 2 -1.03125 1.921875 -1.8125 C 1.90625 -1.9375 1.90625 -2.0625 1.890625 -2.1875 Z M 1.890625 -2.1875 "
           id="path109" />
      </g>
      <g
         id="glyph-1-10">
        <path
           d="M 0.453125 -8.21875 L 0.453125 -7.703125 L 1.71875 -7.703125 L 1.71875 -0.53125 L 0.453125 -0.53125 L 0.453125 -0.015625 L 4.5625 -0.015625 L 4.5625 -0.53125 L 3.296875 -0.53125 L 3.296875 -3.65625 L 4.875 -3.65625 C 6.140625 -3.65625 7.796875 -3.78125 8.328125 -5.296875 C 8.390625 -5.484375 8.421875 -5.6875 8.421875 -5.890625 C 8.421875 -7.4375 6.921875 -8.15625 5.484375 -8.21875 Z M 3.234375 -4.109375 L 3.234375 -7.703125 L 4.734375 -7.703125 C 5.3125 -7.703125 6.0625 -7.671875 6.453125 -7.171875 C 6.734375 -6.84375 6.734375 -6.390625 6.734375 -5.96875 L 6.734375 -5.875 C 6.734375 -5.34375 6.734375 -4.75 6.171875 -4.40625 C 5.734375 -4.125 5.203125 -4.109375 4.703125 -4.109375 Z M 3.234375 -4.109375 "
           id="path112" />
      </g>
      <g
         id="glyph-1-11">
        <path
           d="M 0.421875 -5.296875 L 0.421875 -4.78125 L 0.65625 -4.78125 C 0.96875 -4.78125 1.25 -4.75 1.25 -4.390625 L 1.25 -0.53125 L 0.421875 -0.53125 L 0.421875 -0.015625 L 3.53125 -0.015625 L 3.53125 -0.53125 L 2.484375 -0.53125 L 2.484375 -2.203125 C 2.484375 -3.28125 2.546875 -5 3.96875 -5 L 3.96875 -4.984375 C 3.796875 -4.875 3.71875 -4.671875 3.71875 -4.453125 C 3.71875 -4.046875 4.03125 -3.75 4.40625 -3.75 L 4.484375 -3.75 C 4.859375 -3.796875 5.109375 -4.0625 5.109375 -4.4375 C 5.109375 -5.0625 4.484375 -5.390625 3.921875 -5.390625 C 3.328125 -5.390625 2.8125 -5.015625 2.5625 -4.46875 C 2.484375 -4.34375 2.421875 -4.203125 2.390625 -4.046875 L 2.375 -5.390625 L 1.078125 -5.328125 Z M 0.421875 -5.296875 "
           id="path115" />
      </g>
      <g
         id="glyph-1-12">
        <path
           d="M 2.34375 -5.421875 C 1.4375 -5.34375 0.4375 -5 0.4375 -3.859375 C 0.4375 -2.171875 2.921875 -2.375 3.625 -1.9375 C 3.84375 -1.78125 4.046875 -1.546875 4.046875 -1.25 C 4.046875 -0.59375 3.4375 -0.375 2.9375 -0.34375 L 2.734375 -0.34375 C 2.046875 -0.34375 1.3125 -0.609375 1.046875 -1.546875 C 0.984375 -1.703125 1 -1.9375 0.75 -1.9375 L 0.640625 -1.9375 C 0.484375 -1.9375 0.4375 -1.84375 0.4375 -1.703125 C 0.4375 -1.640625 0.4375 -1.5625 0.4375 -1.515625 L 0.4375 -0.359375 C 0.4375 -0.3125 0.4375 -0.234375 0.4375 -0.171875 C 0.4375 -0.078125 0.453125 0.03125 0.5625 0.0625 L 0.609375 0.0625 C 0.71875 0.0625 0.796875 0 0.890625 -0.0625 L 1.09375 -0.234375 C 1.140625 -0.265625 1.203125 -0.328125 1.28125 -0.328125 L 1.296875 -0.328125 C 1.40625 -0.328125 1.609375 -0.140625 1.796875 -0.078125 C 2.078125 0.03125 2.359375 0.078125 2.671875 0.078125 C 3.640625 0.078125 4.859375 -0.28125 4.859375 -1.640625 C 4.859375 -2.53125 4.140625 -3.15625 3.3125 -3.34375 C 2.625 -3.5 1.25 -3.53125 1.25 -4.265625 C 1.25 -5.015625 2.171875 -5.0625 2.609375 -5.0625 C 3.328125 -5.0625 3.859375 -4.796875 4 -4 C 4 -3.828125 4.046875 -3.78125 4.1875 -3.78125 L 4.28125 -3.78125 C 4.46875 -3.78125 4.5 -3.859375 4.5 -4 L 4.5 -5.0625 C 4.5 -5.109375 4.515625 -5.15625 4.515625 -5.21875 C 4.515625 -5.328125 4.46875 -5.4375 4.34375 -5.4375 C 4.125 -5.4375 3.9375 -5.1875 3.796875 -5.1875 C 3.703125 -5.1875 3.484375 -5.3125 3.328125 -5.34375 C 3.09375 -5.40625 2.828125 -5.4375 2.578125 -5.4375 C 2.5 -5.4375 2.421875 -5.421875 2.34375 -5.421875 Z M 2.34375 -5.421875 "
           id="path118" />
      </g>
      <g
         id="glyph-1-13">
        <path
           d="M 4.28125 -4.921875 C 4.125 -4.765625 4.03125 -4.609375 4.03125 -4.359375 C 4.03125 -3.984375 4.28125 -3.734375 4.65625 -3.65625 L 4.734375 -3.65625 C 5.140625 -3.65625 5.4375 -3.96875 5.4375 -4.359375 C 5.4375 -5.40625 3.9375 -5.4375 3.453125 -5.4375 C 2.71875 -5.4375 2.015625 -5.265625 1.421875 -4.828125 C 0.75 -4.328125 0.4375 -3.5 0.4375 -2.671875 C 0.4375 -1.984375 0.65625 -1.25 1.15625 -0.75 C 1.71875 -0.171875 2.5625 0.0625 3.34375 0.0625 C 4.203125 0.0625 5.078125 -0.28125 5.46875 -1.0625 C 5.5 -1.140625 5.59375 -1.296875 5.59375 -1.40625 C 5.59375 -1.53125 5.484375 -1.546875 5.375 -1.546875 L 5.28125 -1.546875 C 5.046875 -1.546875 5.0625 -1.34375 4.984375 -1.203125 C 4.6875 -0.6875 4.203125 -0.375 3.578125 -0.375 C 2.125 -0.375 1.890625 -1.75 1.890625 -2.75 C 1.890625 -3.625 2.03125 -4.890625 3.265625 -5 L 3.390625 -5 C 3.6875 -5 4 -4.984375 4.28125 -4.921875 Z M 4.28125 -4.921875 "
           id="path121" />
      </g>
      <g
         id="glyph-1-14">
        <path
           d="M 0.5625 -5.296875 L 0.5625 -4.78125 C 0.65625 -4.78125 0.765625 -4.796875 0.859375 -4.796875 C 1.109375 -4.796875 1.34375 -4.734375 1.34375 -4.390625 L 1.34375 -0.53125 L 0.53125 -0.53125 L 0.53125 -0.015625 L 3.328125 -0.015625 L 3.328125 -0.53125 L 2.59375 -0.53125 L 2.59375 -5.390625 L 1.25 -5.390625 Z M 1.703125 -8.3125 C 1.265625 -8.234375 0.9375 -7.90625 0.9375 -7.46875 C 0.9375 -7.015625 1.296875 -6.59375 1.828125 -6.59375 L 1.90625 -6.59375 C 2.34375 -6.6875 2.671875 -7.015625 2.671875 -7.453125 C 2.671875 -7.90625 2.3125 -8.3125 1.78125 -8.3125 Z M 1.703125 -8.3125 "
           id="path124" />
      </g>
      <g
         id="glyph-1-15">
        <path
           d="M 0.421875 -8.21875 L 0.421875 -7.703125 C 0.53125 -7.703125 0.625 -7.703125 0.734375 -7.703125 C 1 -7.703125 1.25 -7.65625 1.25 -7.296875 L 1.25 -0.015625 L 1.75 -0.03125 L 2.328125 -0.6875 C 2.96875 -0.21875 3.296875 0.0625 4.09375 0.0625 C 5.640625 0.0625 7.03125 -0.9375 7.03125 -2.671875 C 7.03125 -4.3125 5.78125 -5.40625 4.25 -5.40625 C 3.59375 -5.40625 3.03125 -5.171875 2.484375 -4.796875 L 2.484375 -8.3125 L 0.859375 -8.234375 Z M 5.5625 -2.21875 C 5.515625 -1.71875 5.484375 -1.25 5.15625 -0.859375 C 4.859375 -0.515625 4.40625 -0.328125 3.96875 -0.328125 C 3.4375 -0.328125 2.546875 -0.75 2.546875 -1.34375 L 2.546875 -4.140625 C 2.609375 -4.546875 3.484375 -5 4.078125 -5 C 5.4375 -5 5.5625 -3.71875 5.5625 -2.828125 L 5.5625 -2.515625 C 5.5625 -2.40625 5.5625 -2.3125 5.5625 -2.21875 Z M 5.5625 -2.21875 "
           id="path127" />
      </g>
      <g
         id="glyph-1-16">
        <path
           d="M 3.125 -8.359375 C 2.46875 -8.28125 1.84375 -8.109375 1.359375 -7.625 C 0.953125 -7.203125 0.734375 -6.609375 0.734375 -6.015625 C 0.734375 -4.921875 1.484375 -4 2.5625 -3.703125 C 3.015625 -3.578125 3.5 -3.5 3.953125 -3.375 C 4.65625 -3.234375 5.640625 -3 5.640625 -1.8125 C 5.640625 -0.84375 4.828125 -0.375 4.046875 -0.375 C 2.90625 -0.375 1.5625 -0.78125 1.296875 -2.15625 L 1.25 -2.5625 C 1.25 -2.6875 1.1875 -2.734375 1.046875 -2.734375 L 0.9375 -2.734375 C 0.796875 -2.734375 0.734375 -2.671875 0.734375 -2.546875 L 0.734375 -0.015625 C 0.75 0.0625 0.78125 0.109375 0.859375 0.125 L 0.90625 0.125 C 1.234375 0.125 1.46875 -0.5 1.671875 -0.53125 L 1.6875 -0.53125 C 1.75 -0.53125 1.859375 -0.421875 1.953125 -0.375 C 2.59375 -0.03125 3.328125 0.125 4.0625 0.125 C 4.84375 0.125 5.671875 -0.109375 6.171875 -0.734375 C 6.53125 -1.1875 6.71875 -1.765625 6.71875 -2.359375 C 6.71875 -3.75 5.75 -4.671875 4.421875 -4.953125 L 3.578125 -5.140625 C 3.25 -5.21875 2.90625 -5.265625 2.59375 -5.421875 C 2.171875 -5.625 1.84375 -6.03125 1.8125 -6.5 L 1.8125 -6.578125 C 1.8125 -7.546875 2.6875 -7.875 3.421875 -7.875 C 4.640625 -7.875 5.640625 -7.09375 5.8125 -5.703125 C 5.828125 -5.5625 5.84375 -5.484375 6.015625 -5.484375 L 6.125 -5.484375 C 6.265625 -5.484375 6.328125 -5.53125 6.328125 -5.671875 L 6.328125 -8.140625 C 6.328125 -8.25 6.3125 -8.359375 6.171875 -8.359375 C 6.015625 -8.359375 5.953125 -8.25 5.84375 -8.140625 L 5.5625 -7.828125 C 5.515625 -7.78125 5.46875 -7.6875 5.40625 -7.6875 L 5.390625 -7.6875 C 5.3125 -7.6875 5.234375 -7.78125 5.1875 -7.8125 C 4.65625 -8.234375 3.9375 -8.359375 3.28125 -8.359375 Z M 3.125 -8.359375 "
           id="path130" />
      </g>
      <g
         id="glyph-1-17">
        <path
           d="M 2 -7.609375 C 2 -6.640625 1.515625 -5.203125 0.25 -5.203125 L 0.25 -4.8125 L 1.203125 -4.8125 L 1.203125 -1.625 C 1.203125 -0.609375 1.6875 0.0625 3.078125 0.0625 C 4 0.0625 4.484375 -0.703125 4.484375 -1.5625 C 4.484375 -1.75 4.46875 -1.953125 4.46875 -2.125 L 3.953125 -2.125 L 3.953125 -1.609375 C 3.953125 -1.15625 3.875 -0.375 3.21875 -0.375 C 2.625 -0.375 2.515625 -1 2.515625 -1.546875 L 2.515625 -4.8125 L 4.25 -4.8125 L 4.25 -5.3125 L 2.515625 -5.3125 L 2.515625 -7.609375 Z M 2 -7.609375 "
           id="path133" />
      </g>
      <g
         id="glyph-1-18">
        <path
           d="M 1.75 -5.3125 C 1.328125 -5.234375 1 -4.90625 1 -4.46875 C 1 -4.015625 1.34375 -3.59375 1.890625 -3.59375 L 1.96875 -3.59375 C 2.40625 -3.6875 2.71875 -4.015625 2.71875 -4.453125 C 2.71875 -4.90625 2.375 -5.3125 1.84375 -5.3125 Z M 1.75 -1.734375 C 1.328125 -1.65625 1 -1.3125 1 -0.890625 C 1 -0.4375 1.34375 -0.015625 1.890625 -0.015625 L 1.96875 -0.015625 C 2.40625 -0.09375 2.71875 -0.4375 2.71875 -0.859375 C 2.71875 -1.3125 2.375 -1.734375 1.84375 -1.734375 Z M 1.75 -1.734375 "
           id="path136" />
      </g>
      <g
         id="glyph-1-19">
        <path
           d="M 0.5 -5.296875 L 0.5 -4.78125 L 0.734375 -4.78125 C 1.046875 -4.78125 1.328125 -4.75 1.328125 -4.390625 L 1.328125 -0.53125 L 0.5 -0.53125 L 0.5 -0.015625 L 3.453125 -0.015625 L 3.453125 -0.53125 L 2.625 -0.53125 L 2.625 -2.5625 C 2.625 -2.703125 2.625 -2.84375 2.625 -3 C 2.625 -3.9375 3.25 -5 4.34375 -5 C 5.015625 -5 5.046875 -4.234375 5.046875 -3.59375 L 5.046875 -0.53125 L 4.21875 -0.53125 L 4.21875 -0.015625 L 7.171875 -0.015625 L 7.171875 -0.53125 L 6.34375 -0.53125 L 6.34375 -3.53125 C 6.34375 -3.9375 6.328125 -4.375 6.109375 -4.75 C 5.78125 -5.296875 5.09375 -5.390625 4.5 -5.390625 C 3.6875 -5.390625 2.796875 -4.890625 2.53125 -4.09375 L 2.515625 -5.390625 L 1.1875 -5.390625 Z M 0.5 -5.296875 "
           id="path139" />
      </g>
      <g
         id="glyph-1-20">
        <path
           d="M 0.453125 -8.21875 L 0.453125 -7.703125 L 1.71875 -7.703125 L 1.71875 -0.53125 L 0.453125 -0.53125 L 0.453125 -0.015625 L 4.5625 -0.015625 L 4.5625 -0.53125 L 3.296875 -0.53125 L 3.296875 -2.84375 L 3.328125 -3.078125 L 4.546875 -4.140625 C 4.609375 -4.015625 4.703125 -3.90625 4.78125 -3.796875 L 5.171875 -3.265625 C 5.78125 -2.46875 6.390625 -1.6875 6.953125 -0.890625 C 7 -0.84375 7.09375 -0.734375 7.09375 -0.671875 L 7.09375 -0.640625 C 7.046875 -0.53125 6.65625 -0.53125 6.390625 -0.53125 L 6.25 -0.53125 L 6.25 -0.015625 L 9.953125 -0.015625 L 9.953125 -0.53125 C 9.828125 -0.53125 9.671875 -0.515625 9.515625 -0.515625 C 9.09375 -0.515625 8.9375 -0.59375 8.71875 -0.890625 C 7.75 -2.140625 6.828125 -3.421875 5.890625 -4.6875 L 5.71875 -4.921875 C 5.6875 -4.953125 5.640625 -5 5.640625 -5.046875 C 5.640625 -5.109375 5.796875 -5.21875 5.875 -5.28125 L 6.59375 -5.890625 C 7.046875 -6.28125 7.5 -6.65625 7.953125 -7.046875 L 8.359375 -7.40625 C 8.578125 -7.546875 8.703125 -7.640625 8.984375 -7.65625 C 9.234375 -7.703125 9.5 -7.703125 9.765625 -7.703125 L 9.765625 -8.21875 L 6.890625 -8.21875 L 6.890625 -7.703125 C 7.140625 -7.703125 7.703125 -7.65625 7.703125 -7.5625 L 7.703125 -7.546875 C 7.703125 -7.453125 6.984375 -6.890625 6.640625 -6.625 C 5.515625 -5.671875 4.453125 -4.671875 3.296875 -3.765625 L 3.296875 -7.703125 L 4.5625 -7.703125 L 4.5625 -8.21875 Z M 0.453125 -8.21875 "
           id="path142" />
      </g>
      <g
         id="glyph-1-21">
        <path
           d="M 0.28125 -5.3125 L 0.28125 -4.8125 L 1.046875 -4.8125 C 1.078125 -4.71875 1.125 -4.640625 1.15625 -4.546875 L 1.34375 -4.140625 C 1.75 -3.28125 2.140625 -2.421875 2.515625 -1.546875 C 2.6875 -1.1875 2.875 -0.828125 3.03125 -0.453125 C 3.140625 -0.234375 3.171875 0.046875 3.53125 0.046875 C 3.875 0.046875 3.9375 -0.171875 4.046875 -0.421875 C 4.15625 -0.65625 4.265625 -0.90625 4.375 -1.140625 L 5.515625 -3.65625 C 5.625 -3.890625 5.734375 -4.125 5.84375 -4.34375 C 6 -4.6875 6.046875 -4.8125 6.796875 -4.8125 L 6.796875 -5.3125 L 4.8125 -5.3125 L 4.8125 -4.8125 C 5 -4.8125 5.328125 -4.796875 5.390625 -4.671875 L 5.390625 -4.65625 C 5.390625 -4.578125 5.328125 -4.484375 5.3125 -4.4375 L 5.046875 -3.84375 C 4.796875 -3.3125 4.546875 -2.78125 4.296875 -2.25 C 4.1875 -1.984375 4.078125 -1.703125 3.9375 -1.453125 L 2.421875 -4.8125 L 3.078125 -4.8125 L 3.078125 -5.3125 Z M 0.28125 -5.3125 "
           id="path145" />
      </g>
      <g
         id="glyph-1-22">
        <path
           d="M 0.28125 -8.21875 L 0.28125 -7.703125 L 1.203125 -7.703125 C 1.40625 -7.703125 1.390625 -7.609375 1.4375 -7.515625 L 1.578125 -7.203125 C 1.734375 -6.828125 1.90625 -6.453125 2.0625 -6.078125 C 2.875 -4.21875 3.6875 -2.359375 4.5 -0.5 C 4.625 -0.21875 4.6875 0.09375 5.015625 0.09375 L 5.109375 0.09375 C 5.453125 0.09375 5.515625 -0.171875 5.59375 -0.40625 C 6.546875 -2.640625 7.515625 -4.890625 8.515625 -7.109375 C 8.65625 -7.4375 8.671875 -7.609375 9.078125 -7.65625 C 9.328125 -7.703125 9.59375 -7.703125 9.859375 -7.703125 L 9.859375 -8.21875 L 7.046875 -8.21875 L 7.046875 -7.703125 C 7.375 -7.703125 8 -7.703125 8.0625 -7.546875 L 8.0625 -7.53125 C 8.0625 -7.421875 7.96875 -7.265625 7.921875 -7.15625 C 7.15625 -5.375 6.328125 -3.609375 5.59375 -1.8125 L 3.03125 -7.703125 L 4.125 -7.703125 L 4.125 -8.21875 Z M 0.28125 -8.21875 "
           id="path148" />
      </g>
      <g
         id="glyph-1-23">
        <path
           d="M 1.40625 -0.140625 C 0.9375 -0.03125 0.375 0.25 0.375 0.890625 C 0.375 2.125 2.21875 2.390625 3.359375 2.390625 C 4.5 2.390625 6.328125 2.171875 6.328125 0.796875 C 6.328125 -0.734375 4.75 -0.984375 3.53125 -0.984375 C 3.234375 -0.984375 2.90625 -0.96875 2.59375 -0.96875 C 2.453125 -0.96875 2.3125 -0.984375 2.15625 -0.984375 C 1.75 -1 1.421875 -1.34375 1.421875 -1.75 C 1.421875 -1.859375 1.453125 -2.109375 1.5625 -2.15625 C 1.671875 -2.15625 1.828125 -2.0625 1.953125 -2.015625 C 2.21875 -1.9375 2.515625 -1.890625 2.8125 -1.875 L 2.984375 -1.875 C 4 -1.875 5.296875 -2.3125 5.296875 -3.640625 C 5.296875 -4.09375 5.109375 -4.484375 4.8125 -4.796875 L 5.15625 -4.953125 L 5.625 -5.0625 C 5.578125 -4.953125 5.5625 -4.859375 5.5625 -4.765625 C 5.5625 -4.484375 5.78125 -4.296875 6.03125 -4.296875 C 6.3125 -4.296875 6.515625 -4.53125 6.515625 -4.796875 C 6.515625 -5.109375 6.234375 -5.421875 5.90625 -5.46875 L 5.796875 -5.46875 C 5.359375 -5.46875 5.03125 -5.3125 4.6875 -5.109375 C 4.640625 -5.078125 4.59375 -5.015625 4.53125 -5.015625 C 4.453125 -5.015625 4.34375 -5.109375 4.265625 -5.15625 C 3.875 -5.328125 3.390625 -5.40625 2.9375 -5.40625 C 1.90625 -5.40625 0.671875 -4.890625 0.671875 -3.640625 C 0.671875 -3.234375 0.84375 -2.828125 1.109375 -2.515625 C 1.140625 -2.484375 1.25 -2.421875 1.25 -2.359375 C 1.25 -2.234375 1.015625 -2 0.953125 -1.78125 C 0.90625 -1.625 0.890625 -1.46875 0.890625 -1.296875 C 0.890625 -0.859375 1.0625 -0.4375 1.40625 -0.140625 Z M 1.34375 0.96875 L 1.34375 0.875 C 1.34375 0.328125 1.796875 0.125 2.359375 0.125 L 3.546875 0.125 C 4.15625 0.125 5.25 0.125 5.359375 0.828125 L 5.359375 0.875 C 5.359375 1.796875 4.09375 2.015625 3.390625 2.015625 C 2.59375 2.015625 1.46875 1.828125 1.34375 0.96875 Z M 1.953125 -3.3125 L 1.953125 -3.703125 C 1.953125 -4.25 2 -5.015625 3 -5.015625 C 3.84375 -5.015625 4.015625 -4.390625 4.015625 -3.578125 C 4.015625 -2.921875 3.84375 -2.25 2.984375 -2.25 C 2.671875 -2.25 2.359375 -2.359375 2.171875 -2.578125 C 2 -2.796875 1.984375 -3.046875 1.953125 -3.3125 Z M 1.953125 -3.3125 "
           id="path151" />
      </g>
      <g
         id="glyph-2-0" />
      <g
         id="glyph-2-1">
        <path
           d="M 5.96875 -1.84375 C 5.984375 -1.875 6 -1.921875 6 -1.953125 C 6 -1.96875 6 -2.078125 5.875 -2.078125 C 5.796875 -2.078125 5.78125 -2.046875 5.703125 -1.875 C 5.203125 -0.703125 4.828125 -0.265625 3.515625 -0.265625 L 2.078125 -0.265625 C 2 -0.28125 1.96875 -0.28125 1.96875 -0.328125 C 1.96875 -0.390625 1.984375 -0.46875 2.015625 -0.515625 L 2.5625 -2.6875 L 3.40625 -2.6875 C 4 -2.6875 4.109375 -2.59375 4.109375 -2.328125 C 4.109375 -2.328125 4.109375 -2.203125 4.0625 -1.96875 C 4.046875 -1.9375 4.03125 -1.890625 4.03125 -1.859375 C 4.03125 -1.859375 4.046875 -1.75 4.15625 -1.75 C 4.25 -1.75 4.265625 -1.796875 4.296875 -1.9375 L 4.71875 -3.609375 C 4.71875 -3.625 4.75 -3.75 4.75 -3.765625 C 4.75 -3.84375 4.6875 -3.875 4.625 -3.875 C 4.53125 -3.875 4.515625 -3.828125 4.484375 -3.6875 C 4.3125 -3.0625 4.109375 -2.953125 3.421875 -2.953125 L 2.625 -2.953125 L 3.09375 -4.859375 C 3.171875 -5.140625 3.171875 -5.15625 3.5 -5.15625 L 4.75 -5.15625 C 5.703125 -5.15625 6.015625 -4.96875 6.015625 -4.265625 C 6.015625 -4.09375 5.96875 -3.890625 5.96875 -3.75 C 5.96875 -3.65625 6.03125 -3.609375 6.09375 -3.609375 C 6.203125 -3.609375 6.203125 -3.6875 6.21875 -3.8125 L 6.359375 -5.171875 C 6.375 -5.21875 6.375 -5.265625 6.375 -5.3125 C 6.375 -5.421875 6.28125 -5.421875 6.140625 -5.421875 L 1.9375 -5.421875 C 1.78125 -5.421875 1.6875 -5.421875 1.6875 -5.265625 C 1.6875 -5.15625 1.796875 -5.15625 1.921875 -5.15625 C 1.953125 -5.15625 2.09375 -5.15625 2.234375 -5.140625 C 2.40625 -5.125 2.421875 -5.09375 2.421875 -5.03125 C 2.421875 -4.984375 2.40625 -4.9375 2.390625 -4.90625 L 1.328125 -0.625 C 1.25 -0.328125 1.234375 -0.265625 0.640625 -0.265625 C 0.5 -0.265625 0.390625 -0.265625 0.390625 -0.109375 C 0.390625 0 0.5 0 0.640625 0 L 4.953125 0 C 5.140625 0 5.15625 0 5.21875 -0.140625 Z M 5.96875 -1.84375 "
           id="path155" />
      </g>
      <g
         id="glyph-2-2">
        <path
           d="M 4.15625 -2.203125 C 4.1875 -2.3125 4.21875 -2.453125 4.21875 -2.625 C 4.21875 -3.234375 3.796875 -3.515625 3.234375 -3.515625 C 2.578125 -3.515625 2.171875 -3.125 1.9375 -2.828125 C 1.875 -3.265625 1.53125 -3.515625 1.125 -3.515625 C 0.84375 -3.515625 0.640625 -3.328125 0.515625 -3.078125 C 0.328125 -2.71875 0.234375 -2.3125 0.234375 -2.296875 C 0.234375 -2.21875 0.296875 -2.1875 0.359375 -2.1875 C 0.46875 -2.1875 0.46875 -2.21875 0.53125 -2.4375 C 0.625 -2.84375 0.765625 -3.296875 1.09375 -3.296875 C 1.296875 -3.296875 1.359375 -3.109375 1.359375 -2.921875 C 1.359375 -2.765625 1.3125 -2.625 1.25 -2.359375 C 1.234375 -2.296875 1.109375 -1.828125 1.078125 -1.71875 L 0.78125 -0.515625 C 0.75 -0.390625 0.703125 -0.203125 0.703125 -0.171875 C 0.703125 0.015625 0.859375 0.078125 0.96875 0.078125 C 1.109375 0.078125 1.234375 -0.015625 1.28125 -0.109375 C 1.3125 -0.15625 1.375 -0.4375 1.40625 -0.59375 L 1.59375 -1.3125 C 1.625 -1.421875 1.703125 -1.734375 1.71875 -1.84375 C 1.828125 -2.28125 1.828125 -2.28125 2.015625 -2.546875 C 2.28125 -2.9375 2.65625 -3.296875 3.1875 -3.296875 C 3.46875 -3.296875 3.640625 -3.125 3.640625 -2.75 C 3.640625 -2.59375 3.578125 -2.296875 3.578125 -2.296875 L 2.671875 1.28125 C 2.640625 1.40625 2.640625 1.453125 2.640625 1.46875 C 2.640625 1.671875 2.8125 1.71875 2.90625 1.71875 C 3.171875 1.71875 3.25 1.453125 3.265625 1.359375 Z M 4.15625 -2.203125 "
           id="path158" />
      </g>
      <g
         id="glyph-2-3">
        <path
           d="M 4.375 -2.90625 C 4.515625 -2.90625 4.578125 -2.90625 4.671875 -2.96875 C 4.75 -3.046875 4.796875 -3.15625 4.796875 -3.21875 C 4.796875 -3.4375 4.59375 -3.4375 4.453125 -3.4375 L 2.5 -3.4375 C 1.265625 -3.4375 0.328125 -2.171875 0.328125 -1.21875 C 0.328125 -0.4375 0.890625 0.078125 1.625 0.078125 C 2.625 0.078125 3.71875 -0.890625 3.71875 -2.078125 C 3.71875 -2.5 3.5625 -2.75 3.484375 -2.90625 Z M 1.640625 -0.140625 C 1.234375 -0.140625 0.890625 -0.40625 0.890625 -0.984375 C 0.890625 -1.328125 1.078125 -2.90625 2.359375 -2.90625 C 3.140625 -2.90625 3.140625 -2.3125 3.140625 -2.15625 C 3.140625 -1.328125 2.578125 -0.140625 1.640625 -0.140625 Z M 1.640625 -0.140625 "
           id="path161" />
      </g>
      <g
         id="glyph-3-0" />
      <g
         id="glyph-3-1">
        <path
           d="M 2.203125 -7.359375 C 2.203125 -7.71875 1.90625 -7.953125 1.625 -7.953125 C 1.296875 -7.953125 1.046875 -7.6875 1.046875 -7.359375 C 1.046875 -7.046875 1.296875 -6.796875 1.609375 -6.796875 C 1.96875 -6.796875 2.203125 -7.078125 2.203125 -7.359375 Z M 2.203125 -7.359375 "
           id="path165" />
      </g>
      <g
         id="glyph-3-2">
        <path
           d="M 8.0625 -3.875 C 8.234375 -3.875 8.453125 -3.875 8.453125 -4.09375 C 8.453125 -4.3125 8.25 -4.3125 8.0625 -4.3125 L 1.03125 -4.3125 C 0.859375 -4.3125 0.640625 -4.3125 0.640625 -4.09375 C 0.640625 -3.875 0.84375 -3.875 1.03125 -3.875 Z M 8.0625 -1.65625 C 8.234375 -1.65625 8.453125 -1.65625 8.453125 -1.859375 C 8.453125 -2.09375 8.25 -2.09375 8.0625 -2.09375 L 1.03125 -2.09375 C 0.859375 -2.09375 0.640625 -2.09375 0.640625 -1.875 C 0.640625 -1.65625 0.84375 -1.65625 1.03125 -1.65625 Z M 8.0625 -1.65625 "
           id="path168" />
      </g>
      <g
         id="glyph-3-3">
        <path
           d="M 4.765625 -2.765625 L 8.0625 -2.765625 C 8.234375 -2.765625 8.453125 -2.765625 8.453125 -2.96875 C 8.453125 -3.203125 8.25 -3.203125 8.0625 -3.203125 L 4.765625 -3.203125 L 4.765625 -6.5 C 4.765625 -6.671875 4.765625 -6.890625 4.546875 -6.890625 C 4.328125 -6.890625 4.328125 -6.6875 4.328125 -6.5 L 4.328125 -3.203125 L 1.03125 -3.203125 C 0.859375 -3.203125 0.640625 -3.203125 0.640625 -2.984375 C 0.640625 -2.765625 0.84375 -2.765625 1.03125 -2.765625 L 4.328125 -2.765625 L 4.328125 0.53125 C 4.328125 0.703125 4.328125 0.921875 4.546875 0.921875 C 4.765625 0.921875 4.765625 0.71875 4.765625 0.53125 Z M 4.765625 -2.765625 "
           id="path171" />
      </g>
      <g
         id="glyph-3-4">
        <path
           d="M 3.890625 2.90625 C 3.890625 2.875 3.890625 2.84375 3.6875 2.640625 C 2.484375 1.4375 1.8125 -0.53125 1.8125 -2.96875 C 1.8125 -5.296875 2.375 -7.296875 3.765625 -8.703125 C 3.890625 -8.8125 3.890625 -8.828125 3.890625 -8.875 C 3.890625 -8.9375 3.828125 -8.96875 3.78125 -8.96875 C 3.625 -8.96875 2.640625 -8.109375 2.0625 -6.9375 C 1.453125 -5.71875 1.171875 -4.453125 1.171875 -2.96875 C 1.171875 -1.90625 1.34375 -0.484375 1.953125 0.78125 C 2.671875 2.21875 3.640625 3 3.78125 3 C 3.828125 3 3.890625 2.96875 3.890625 2.90625 Z M 3.890625 2.90625 "
           id="path174" />
      </g>
      <g
         id="glyph-3-5">
        <path
           d="M 5.359375 -3.828125 C 5.359375 -4.8125 5.296875 -5.78125 4.859375 -6.6875 C 4.375 -7.6875 3.515625 -7.953125 2.921875 -7.953125 C 2.234375 -7.953125 1.390625 -7.609375 0.9375 -6.609375 C 0.609375 -5.859375 0.484375 -5.109375 0.484375 -3.828125 C 0.484375 -2.671875 0.578125 -1.796875 1 -0.9375 C 1.46875 -0.03125 2.296875 0.25 2.921875 0.25 C 3.953125 0.25 4.546875 -0.375 4.90625 -1.0625 C 5.328125 -1.953125 5.359375 -3.125 5.359375 -3.828125 Z M 2.921875 0.015625 C 2.53125 0.015625 1.75 -0.203125 1.53125 -1.5 C 1.40625 -2.21875 1.40625 -3.125 1.40625 -3.96875 C 1.40625 -4.953125 1.40625 -5.828125 1.59375 -6.53125 C 1.796875 -7.34375 2.40625 -7.703125 2.921875 -7.703125 C 3.375 -7.703125 4.0625 -7.4375 4.296875 -6.40625 C 4.453125 -5.71875 4.453125 -4.78125 4.453125 -3.96875 C 4.453125 -3.171875 4.453125 -2.265625 4.3125 -1.53125 C 4.09375 -0.21875 3.328125 0.015625 2.921875 0.015625 Z M 2.921875 0.015625 "
           id="path177" />
      </g>
      <g
         id="glyph-3-6">
        <path
           d="M 3.375 -2.96875 C 3.375 -3.890625 3.25 -5.359375 2.578125 -6.75 C 1.875 -8.1875 0.890625 -8.96875 0.765625 -8.96875 C 0.71875 -8.96875 0.65625 -8.9375 0.65625 -8.875 C 0.65625 -8.828125 0.65625 -8.8125 0.859375 -8.609375 C 2.0625 -7.40625 2.71875 -5.421875 2.71875 -2.984375 C 2.71875 -0.671875 2.15625 1.328125 0.78125 2.734375 C 0.65625 2.84375 0.65625 2.875 0.65625 2.90625 C 0.65625 2.96875 0.71875 3 0.765625 3 C 0.921875 3 1.90625 2.140625 2.484375 0.96875 C 3.09375 -0.25 3.375 -1.546875 3.375 -2.96875 Z M 3.375 -2.96875 "
           id="path180" />
      </g>
      <g
         id="glyph-3-7">
        <path
           d="M 4.703125 -7.9375 C 4.34375 -7.59375 4.09375 -7.34375 3.71875 -7.34375 C 3.53125 -7.34375 3.375 -7.390625 3 -7.640625 C 2.765625 -7.78125 2.515625 -7.9375 2.25 -7.9375 C 1.8125 -7.9375 1.546875 -7.640625 0.984375 -7.015625 L 1.140625 -6.84375 C 1.5 -7.203125 1.75 -7.4375 2.125 -7.4375 C 2.3125 -7.4375 2.46875 -7.40625 2.84375 -7.140625 C 3.078125 -7 3.328125 -6.84375 3.59375 -6.84375 C 4.046875 -6.84375 4.296875 -7.140625 4.859375 -7.765625 Z M 4.703125 -7.9375 "
           id="path183" />
      </g>
      <g
         id="glyph-4-0" />
      <g
         id="glyph-4-1">
        <path
           d="M 1.65625 -2.71875 C 2.046875 -2.5625 2.453125 -2.5625 2.671875 -2.5625 C 2.984375 -2.5625 3.609375 -2.5625 3.609375 -2.921875 C 3.609375 -3.125 3.375 -3.21875 2.765625 -3.21875 C 2.46875 -3.21875 2.109375 -3.171875 1.703125 -3 C 1.328125 -3.171875 1.1875 -3.453125 1.1875 -3.71875 C 1.1875 -4.453125 2.359375 -4.890625 3.421875 -4.890625 C 3.625 -4.890625 4.046875 -4.890625 4.546875 -4.515625 C 4.625 -4.46875 4.65625 -4.4375 4.75 -4.4375 C 4.890625 -4.4375 5.046875 -4.59375 5.046875 -4.734375 C 5.046875 -4.953125 4.34375 -5.40625 3.53125 -5.40625 C 2.1875 -5.40625 0.921875 -4.609375 0.921875 -3.71875 C 0.921875 -3.28125 1.203125 -3 1.40625 -2.859375 C 0.71875 -2.46875 0.3125 -1.8125 0.3125 -1.234375 C 0.3125 -0.40625 1.046875 0.25 2.203125 0.25 C 3.78125 0.25 4.40625 -0.796875 4.40625 -0.96875 C 4.40625 -1.03125 4.359375 -1.078125 4.296875 -1.078125 C 4.25 -1.078125 4.21875 -1.046875 4.171875 -0.96875 C 4.046875 -0.734375 3.734375 -0.265625 2.3125 -0.265625 C 1.5625 -0.265625 0.578125 -0.453125 0.578125 -1.296875 C 0.578125 -1.703125 0.890625 -2.3125 1.65625 -2.71875 Z M 2.03125 -2.875 C 2.359375 -2.96875 2.671875 -2.96875 2.75 -2.96875 C 3.078125 -2.96875 3.140625 -2.953125 3.328125 -2.90625 C 3.125 -2.8125 3.109375 -2.8125 2.671875 -2.8125 C 2.46875 -2.8125 2.265625 -2.8125 2.03125 -2.875 Z M 2.03125 -2.875 "
           id="path187" />
      </g>
      <g
         id="glyph-4-2">
        <path
           d="M 6.078125 -4.5 C 6.234375 -4.5 6.625 -4.5 6.625 -4.890625 C 6.625 -5.15625 6.390625 -5.15625 6.1875 -5.15625 L 3.53125 -5.15625 C 1.75 -5.15625 0.453125 -3.15625 0.453125 -1.75 C 0.453125 -0.734375 1.109375 0.125 2.1875 0.125 C 3.59375 0.125 5.140625 -1.40625 5.140625 -3.1875 C 5.140625 -3.65625 5.03125 -4.109375 4.75 -4.5 Z M 2.203125 -0.125 C 1.59375 -0.125 1.140625 -0.578125 1.140625 -1.40625 C 1.140625 -2.125 1.578125 -4.5 3.328125 -4.5 C 3.84375 -4.5 4.421875 -4.25 4.421875 -3.328125 C 4.421875 -2.921875 4.234375 -1.90625 3.8125 -1.21875 C 3.375 -0.515625 2.734375 -0.125 2.203125 -0.125 Z M 2.203125 -0.125 "
           id="path190" />
      </g>
      <g
         id="glyph-4-3">
        <path
           d="M 8.3125 -2.765625 C 8.3125 -2.8125 8.359375 -2.890625 8.359375 -2.9375 C 8.359375 -3 8.3125 -3.0625 8.234375 -3.0625 C 8.1875 -3.0625 8.15625 -3.046875 8.125 -3.015625 C 8.109375 -3 8.109375 -2.96875 8 -2.734375 C 7.296875 -1.0625 6.78125 -0.34375 4.859375 -0.34375 L 3.125 -0.34375 C 2.953125 -0.34375 2.921875 -0.34375 2.859375 -0.359375 C 2.71875 -0.375 2.71875 -0.390625 2.71875 -0.484375 C 2.71875 -0.578125 2.734375 -0.640625 2.765625 -0.75 L 3.578125 -4.046875 L 4.765625 -4.046875 C 5.703125 -4.046875 5.765625 -3.84375 5.765625 -3.484375 C 5.765625 -3.375 5.765625 -3.265625 5.6875 -2.90625 C 5.671875 -2.859375 5.65625 -2.8125 5.65625 -2.765625 C 5.65625 -2.6875 5.71875 -2.65625 5.78125 -2.65625 C 5.890625 -2.65625 5.90625 -2.734375 5.953125 -2.90625 L 6.640625 -5.671875 C 6.640625 -5.734375 6.59375 -5.796875 6.515625 -5.796875 C 6.40625 -5.796875 6.390625 -5.75 6.34375 -5.578125 C 6.109375 -4.65625 5.875 -4.40625 4.8125 -4.40625 L 3.671875 -4.40625 L 4.40625 -7.34375 C 4.515625 -7.75 4.546875 -7.796875 5.03125 -7.796875 L 6.734375 -7.796875 C 8.21875 -7.796875 8.515625 -7.40625 8.515625 -6.484375 C 8.515625 -6.484375 8.515625 -6.140625 8.46875 -5.75 C 8.453125 -5.703125 8.4375 -5.625 8.4375 -5.609375 C 8.4375 -5.515625 8.5 -5.46875 8.578125 -5.46875 C 8.65625 -5.46875 8.703125 -5.515625 8.71875 -5.734375 L 8.984375 -7.828125 C 8.984375 -7.859375 9 -7.984375 9 -8.015625 C 9 -8.140625 8.890625 -8.140625 8.671875 -8.140625 L 2.84375 -8.140625 C 2.625 -8.140625 2.5 -8.140625 2.5 -7.921875 C 2.5 -7.796875 2.578125 -7.796875 2.78125 -7.796875 C 3.53125 -7.796875 3.53125 -7.703125 3.53125 -7.578125 C 3.53125 -7.515625 3.515625 -7.46875 3.484375 -7.34375 L 1.859375 -0.890625 C 1.75 -0.46875 1.734375 -0.34375 0.890625 -0.34375 C 0.671875 -0.34375 0.546875 -0.34375 0.546875 -0.125 C 0.546875 0 0.625 0 0.859375 0 L 6.859375 0 C 7.125 0 7.140625 -0.015625 7.21875 -0.203125 Z M 8.3125 -2.765625 "
           id="path193" />
      </g>
      <g
         id="glyph-4-4">
        <path
           d="M 5.671875 -3.3125 C 5.734375 -3.546875 5.765625 -3.6875 5.765625 -4.015625 C 5.765625 -4.734375 5.359375 -5.265625 4.453125 -5.265625 C 3.375 -5.265625 2.828125 -4.515625 2.609375 -4.21875 C 2.5625 -4.90625 2.078125 -5.265625 1.546875 -5.265625 C 1.203125 -5.265625 0.9375 -5.109375 0.703125 -4.65625 C 0.484375 -4.21875 0.328125 -3.484375 0.328125 -3.4375 C 0.328125 -3.390625 0.375 -3.328125 0.453125 -3.328125 C 0.546875 -3.328125 0.5625 -3.34375 0.640625 -3.625 C 0.8125 -4.328125 1.046875 -5.03125 1.515625 -5.03125 C 1.796875 -5.03125 1.890625 -4.84375 1.890625 -4.484375 C 1.890625 -4.21875 1.765625 -3.75 1.6875 -3.375 L 1.34375 -2.09375 C 1.296875 -1.859375 1.171875 -1.328125 1.109375 -1.109375 C 1.03125 -0.796875 0.890625 -0.234375 0.890625 -0.171875 C 0.890625 -0.015625 1.03125 0.125 1.203125 0.125 C 1.34375 0.125 1.515625 0.046875 1.609375 -0.125 C 1.640625 -0.1875 1.75 -0.609375 1.8125 -0.84375 L 2.0625 -1.921875 L 2.46875 -3.5 C 2.484375 -3.578125 2.78125 -4.171875 3.234375 -4.546875 C 3.53125 -4.84375 3.9375 -5.03125 4.40625 -5.03125 C 4.890625 -5.03125 5.0625 -4.671875 5.0625 -4.203125 C 5.0625 -3.84375 5.015625 -3.65625 4.953125 -3.4375 L 3.5625 2.0625 C 3.546875 2.125 3.53125 2.203125 3.53125 2.265625 C 3.53125 2.453125 3.671875 2.5625 3.84375 2.5625 C 3.953125 2.5625 4.203125 2.515625 4.296875 2.15625 Z M 5.671875 -3.3125 "
           id="path196" />
      </g>
      <g
         id="glyph-4-5">
        <path
           d="M 2.40625 -4.8125 L 3.5 -4.8125 C 3.734375 -4.8125 3.84375 -4.8125 3.84375 -5.015625 C 3.84375 -5.15625 3.78125 -5.15625 3.53125 -5.15625 L 2.484375 -5.15625 L 2.921875 -6.890625 C 2.96875 -7.0625 2.96875 -7.09375 2.96875 -7.171875 C 2.96875 -7.359375 2.828125 -7.46875 2.671875 -7.46875 C 2.5625 -7.46875 2.296875 -7.4375 2.203125 -7.046875 L 1.734375 -5.15625 L 0.609375 -5.15625 C 0.375 -5.15625 0.265625 -5.15625 0.265625 -4.921875 C 0.265625 -4.8125 0.34375 -4.8125 0.578125 -4.8125 L 1.640625 -4.8125 L 0.84375 -1.65625 C 0.75 -1.234375 0.71875 -1.109375 0.71875 -0.953125 C 0.71875 -0.390625 1.109375 0.125 1.78125 0.125 C 2.984375 0.125 3.640625 -1.625 3.640625 -1.703125 C 3.640625 -1.78125 3.578125 -1.8125 3.515625 -1.8125 C 3.484375 -1.8125 3.4375 -1.8125 3.421875 -1.765625 C 3.40625 -1.75 3.390625 -1.75 3.3125 -1.546875 C 3.0625 -0.953125 2.515625 -0.125 1.8125 -0.125 C 1.453125 -0.125 1.4375 -0.421875 1.4375 -0.6875 C 1.4375 -0.6875 1.4375 -0.921875 1.46875 -1.0625 Z M 2.40625 -4.8125 "
           id="path199" />
      </g>
      <g
         id="glyph-5-0" />
      <g
         id="glyph-5-1">
        <path
           d="M 3.71875 -8.96875 C 3.296875 -8.8125 2.515625 -7.765625 2.140625 -7.09375 C 1.453125 -5.84375 1.1875 -4.40625 1.1875 -2.984375 C 1.1875 -0.78125 1.859375 1.40625 3.578125 2.890625 C 3.640625 2.921875 3.71875 2.984375 3.796875 2.984375 C 3.84375 2.984375 3.890625 2.921875 3.890625 2.890625 C 3.890625 2.765625 3.546875 2.5 3.4375 2.34375 C 2.234375 0.921875 1.828125 -1.046875 1.828125 -2.890625 C 1.828125 -4.890625 2.21875 -7.140625 3.703125 -8.640625 C 3.78125 -8.71875 3.890625 -8.796875 3.890625 -8.875 C 3.890625 -8.9375 3.828125 -8.984375 3.765625 -8.984375 C 3.734375 -8.984375 3.734375 -8.984375 3.71875 -8.96875 Z M 3.71875 -8.96875 "
           id="path203" />
      </g>
      <g
         id="glyph-5-2">
        <path
           d="M 1.09375 -7.203125 L 1.09375 -6.84375 C 1.625 -6.84375 2.078125 -6.9375 2.609375 -7.15625 L 2.609375 -0.890625 C 2.609375 -0.421875 2.140625 -0.34375 1.671875 -0.34375 C 1.484375 -0.34375 1.296875 -0.359375 1.140625 -0.359375 L 1.140625 -0.015625 L 4.890625 -0.015625 L 4.890625 -0.359375 C 4.75 -0.359375 4.546875 -0.34375 4.375 -0.34375 C 3.78125 -0.34375 3.4375 -0.40625 3.4375 -0.921875 L 3.4375 -7.78125 C 3.4375 -7.859375 3.40625 -7.953125 3.28125 -7.953125 C 3.125 -7.953125 2.96875 -7.734375 2.828125 -7.65625 C 2.3125 -7.296875 1.703125 -7.203125 1.09375 -7.203125 Z M 1.09375 -7.203125 "
           id="path206" />
      </g>
      <g
         id="glyph-5-3">
        <path
           d="M 1.53125 -1.15625 C 1.28125 -1.109375 1.046875 -0.890625 1.046875 -0.59375 C 1.046875 -0.28125 1.296875 -0.015625 1.609375 -0.015625 C 1.921875 -0.015625 2.203125 -0.25 2.203125 -0.578125 C 2.203125 -0.890625 1.9375 -1.171875 1.625 -1.171875 C 1.59375 -1.171875 1.5625 -1.15625 1.53125 -1.15625 Z M 1.53125 -1.15625 "
           id="path209" />
      </g>
      <g
         id="glyph-5-4">
        <path
           d="M 1.21875 -6.875 C 1.515625 -7.390625 2.1875 -7.671875 2.796875 -7.671875 C 3.5 -7.671875 4.015625 -7.21875 4.015625 -6.28125 C 4.015625 -5.5625 3.71875 -4.625 2.96875 -4.40625 C 2.734375 -4.3125 2.46875 -4.375 2.25 -4.296875 L 2.203125 -4.296875 C 2.09375 -4.296875 1.953125 -4.296875 1.953125 -4.1875 C 1.953125 -4.078125 2.03125 -4.046875 2.140625 -4.046875 L 2.265625 -4.046875 C 2.421875 -4.046875 2.5625 -4.0625 2.71875 -4.0625 C 3.84375 -4.0625 4.234375 -3.0625 4.234375 -2.171875 C 4.234375 -1.40625 4.046875 -0.078125 2.859375 -0.078125 C 2.09375 -0.078125 1.375 -0.421875 0.9375 -1.140625 L 1.046875 -1.140625 C 1.421875 -1.140625 1.6875 -1.359375 1.6875 -1.734375 C 1.6875 -2.09375 1.40625 -2.3125 1.046875 -2.3125 L 1 -2.3125 C 0.6875 -2.28125 0.484375 -2.015625 0.484375 -1.71875 C 0.484375 -0.484375 1.71875 0.234375 2.859375 0.234375 C 4.140625 0.234375 5.34375 -0.71875 5.34375 -2.0625 C 5.34375 -3.125 4.40625 -4.125 3.3125 -4.203125 C 4.328125 -4.609375 5.015625 -5.296875 5.015625 -6.328125 C 5.015625 -7.453125 3.765625 -7.953125 2.859375 -7.953125 C 1.953125 -7.953125 0.8125 -7.453125 0.8125 -6.390625 C 0.8125 -6.125 0.9375 -5.84375 1.28125 -5.78125 L 1.359375 -5.78125 C 1.671875 -5.78125 1.90625 -6.03125 1.90625 -6.328125 C 1.90625 -6.640625 1.703125 -6.890625 1.34375 -6.890625 C 1.296875 -6.890625 1.265625 -6.890625 1.21875 -6.875 Z M 1.21875 -6.875 "
           id="path212" />
      </g>
      <g
         id="glyph-5-5">
        <path
           d="M 0.703125 -8.96875 C 0.671875 -8.953125 0.65625 -8.921875 0.65625 -8.890625 C 0.65625 -8.734375 0.96875 -8.515625 1.09375 -8.359375 C 2.328125 -6.859375 2.71875 -4.84375 2.71875 -2.921875 C 2.71875 -1.109375 2.328125 0.84375 1.171875 2.28125 L 0.890625 2.609375 C 0.796875 2.6875 0.65625 2.78125 0.65625 2.890625 C 0.65625 2.9375 0.703125 2.96875 0.765625 2.96875 L 0.796875 2.96875 C 0.9375 2.953125 1.15625 2.71875 1.3125 2.5625 C 2.765625 1.09375 3.359375 -0.953125 3.359375 -2.96875 C 3.359375 -5.171875 2.6875 -7.40625 0.9375 -8.875 C 0.890625 -8.921875 0.84375 -8.984375 0.765625 -8.984375 C 0.734375 -8.984375 0.734375 -8.984375 0.703125 -8.96875 Z M 0.703125 -8.96875 "
           id="path215" />
      </g>
      <g
         id="glyph-5-6">
        <path
           d="M 0.53125 -8.171875 L 0.53125 -7.828125 L 0.921875 -7.828125 C 1.3125 -7.828125 1.671875 -7.78125 1.671875 -7.34375 C 1.671875 -7.25 1.65625 -7.1875 1.65625 -7.109375 L 1.65625 -1.203125 C 1.65625 -0.4375 1.03125 -0.359375 0.53125 -0.359375 L 0.53125 -0.015625 L 3.078125 -0.015625 L 3.078125 -0.359375 C 2.53125 -0.359375 1.953125 -0.46875 1.953125 -1.265625 L 1.953125 -7.78125 C 2.015625 -7.578125 2.109375 -7.375 2.1875 -7.171875 C 2.875 -5.390625 3.53125 -3.625 4.21875 -1.84375 L 4.75 -0.4375 C 4.8125 -0.28125 4.859375 -0.046875 5.03125 -0.015625 L 5.046875 -0.015625 C 5.21875 -0.015625 5.265625 -0.28125 5.3125 -0.421875 L 7.4375 -5.9375 C 7.59375 -6.359375 7.75 -6.78125 7.90625 -7.203125 L 8.0625 -7.59375 C 8.09375 -7.671875 8.125 -7.75 8.15625 -7.859375 L 8.15625 -1.15625 C 8.15625 -1.0625 8.171875 -0.953125 8.171875 -0.859375 C 8.171875 -0.40625 7.8125 -0.34375 7.4375 -0.34375 C 7.296875 -0.34375 7.140625 -0.359375 7.03125 -0.359375 L 7.03125 -0.015625 L 10.1875 -0.015625 L 10.1875 -0.359375 L 9.796875 -0.359375 C 9.40625 -0.359375 9.03125 -0.40625 9.03125 -0.859375 C 9.03125 -0.9375 9.046875 -1.015625 9.046875 -1.09375 L 9.046875 -7.296875 C 9.046875 -7.765625 9.40625 -7.84375 9.765625 -7.84375 C 9.90625 -7.84375 10.046875 -7.828125 10.1875 -7.828125 L 10.1875 -8.171875 L 8.265625 -8.171875 L 8.0625 -8.140625 L 7.828125 -7.625 L 5.359375 -1.15625 L 5.34375 -1.15625 L 2.875 -7.625 L 2.640625 -8.140625 L 2.4375 -8.171875 Z M 0.53125 -8.171875 "
           id="path218" />
      </g>
      <g
         id="glyph-5-7">
        <path
           d="M 1.25 -4.40625 C 1.546875 -4.859375 2.0625 -5.09375 2.59375 -5.09375 C 3.28125 -5.09375 3.828125 -4.40625 3.828125 -3.734375 L 3.828125 -3.09375 C 2.625 -3.09375 0.515625 -2.765625 0.515625 -1.125 L 0.515625 -1 C 0.625 -0.1875 1.609375 0.125 2.3125 0.125 C 2.9375 0.125 3.71875 -0.265625 3.890625 -0.921875 L 3.90625 -0.921875 C 3.9375 -0.359375 4.34375 0.046875 4.828125 0.046875 C 5.328125 0.046875 5.71875 -0.375 5.765625 -0.875 L 5.765625 -1.75 L 5.515625 -1.75 L 5.515625 -1.15625 C 5.515625 -0.8125 5.453125 -0.296875 5.0625 -0.296875 C 4.671875 -0.296875 4.59375 -0.8125 4.59375 -1.109375 C 4.59375 -1.25 4.609375 -1.375 4.609375 -1.5 L 4.609375 -3.171875 C 4.609375 -3.296875 4.609375 -3.4375 4.609375 -3.578125 C 4.609375 -4.703125 3.578125 -5.328125 2.59375 -5.328125 C 1.828125 -5.328125 0.859375 -4.875 0.859375 -3.9375 C 0.859375 -3.59375 1.09375 -3.40625 1.375 -3.40625 C 1.65625 -3.40625 1.859375 -3.640625 1.859375 -3.90625 C 1.859375 -4.203125 1.640625 -4.40625 1.34375 -4.40625 Z M 3.828125 -2.875 L 3.828125 -1.75 C 3.828125 -0.890625 3.28125 -0.125 2.4375 -0.125 C 1.984375 -0.125 1.375 -0.484375 1.375 -1.09375 C 1.375 -2.15625 2.328125 -2.6875 3.328125 -2.828125 C 3.484375 -2.859375 3.65625 -2.84375 3.828125 -2.875 Z M 3.828125 -2.875 "
           id="path221" />
      </g>
      <g
         id="glyph-5-8">
        <path
           d="M 1.75 -7.359375 C 1.75 -6.59375 1.4375 -5.046875 0.21875 -5.046875 L 0.21875 -4.8125 L 1.234375 -4.8125 L 1.234375 -2.109375 C 1.234375 -1.9375 1.21875 -1.765625 1.21875 -1.609375 C 1.21875 -0.53125 1.765625 0.109375 2.765625 0.109375 C 3.6875 0.109375 3.890625 -0.921875 3.890625 -1.65625 L 3.890625 -2.171875 L 3.640625 -2.171875 C 3.640625 -2 3.640625 -1.8125 3.640625 -1.640625 C 3.640625 -1.125 3.546875 -0.15625 2.828125 -0.15625 C 2.140625 -0.15625 2.015625 -0.984375 2.015625 -1.5625 L 2.015625 -4.8125 L 3.6875 -4.8125 L 3.6875 -5.15625 L 2.015625 -5.15625 L 2.015625 -7.359375 Z M 1.75 -7.359375 "
           id="path224" />
      </g>
      <g
         id="glyph-5-9">
        <path
           d="M 1.265625 -2.78125 L 4.6875 -2.78125 C 4.8125 -2.78125 4.859375 -2.828125 4.859375 -2.953125 C 4.859375 -4.1875 4.203125 -5.328125 2.796875 -5.328125 C 1.359375 -5.328125 0.34375 -4.03125 0.34375 -2.640625 C 0.34375 -1.59375 0.90625 -0.53125 1.953125 -0.09375 C 2.21875 0.03125 2.515625 0.109375 2.828125 0.109375 L 2.859375 0.109375 C 3.734375 0.109375 4.578125 -0.421875 4.828125 -1.296875 C 4.84375 -1.34375 4.859375 -1.390625 4.859375 -1.4375 C 4.859375 -1.5 4.796875 -1.546875 4.734375 -1.546875 C 4.59375 -1.546875 4.53125 -1.234375 4.453125 -1.078125 C 4.140625 -0.53125 3.578125 -0.15625 2.9375 -0.15625 C 2.484375 -0.15625 2.078125 -0.40625 1.796875 -0.734375 C 1.3125 -1.3125 1.265625 -2.0625 1.265625 -2.78125 Z M 1.28125 -3.015625 C 1.28125 -3.921875 1.78125 -5.09375 2.765625 -5.09375 C 3.828125 -5.09375 4.109375 -3.859375 4.109375 -3.015625 Z M 1.28125 -3.015625 "
           id="path227" />
      </g>
      <g
         id="glyph-5-10">
        <path
           d="M 0.328125 -5.140625 L 0.328125 -4.796875 L 0.53125 -4.796875 C 0.890625 -4.796875 1.25 -4.75 1.25 -4.203125 L 1.25 -0.859375 C 1.25 -0.421875 1.015625 -0.359375 0.328125 -0.359375 L 0.328125 -0.015625 L 3.125 -0.015625 L 3.125 -0.359375 C 3 -0.359375 2.859375 -0.34375 2.71875 -0.34375 C 2.328125 -0.34375 2 -0.40625 2 -0.84375 L 2 -2.46875 C 2 -3.390625 2.140625 -4.703125 3.125 -5 C 3.21875 -5.015625 3.296875 -5.03125 3.390625 -5.03125 C 3.453125 -5.03125 3.5 -5.015625 3.5625 -5.015625 C 3.375 -4.9375 3.28125 -4.75 3.28125 -4.5625 C 3.28125 -4.296875 3.5 -4.09375 3.734375 -4.09375 C 4.046875 -4.09375 4.21875 -4.34375 4.21875 -4.578125 C 4.21875 -5.015625 3.796875 -5.265625 3.390625 -5.265625 C 2.765625 -5.265625 2.296875 -4.8125 2.0625 -4.296875 C 2.015625 -4.1875 1.953125 -4.0625 1.953125 -3.9375 L 1.9375 -5.265625 Z M 0.328125 -5.140625 "
           id="path230" />
      </g>
      <g
         id="glyph-5-11">
        <path
           d="M 0.4375 -5.140625 L 0.4375 -4.796875 L 0.640625 -4.796875 C 1.015625 -4.796875 1.296875 -4.734375 1.296875 -4.203125 L 1.296875 -0.859375 C 1.296875 -0.421875 1.078125 -0.359375 0.390625 -0.359375 L 0.390625 -0.015625 L 2.875 -0.015625 L 2.875 -0.359375 L 2.703125 -0.359375 C 2.359375 -0.359375 2.0625 -0.375 2.0625 -0.78125 L 2.0625 -5.265625 Z M 1.40625 -7.9375 C 1.09375 -7.890625 0.921875 -7.625 0.921875 -7.375 C 0.921875 -7.125 1.109375 -6.796875 1.484375 -6.796875 C 1.859375 -6.796875 2.078125 -7.078125 2.078125 -7.359375 C 2.078125 -7.609375 1.890625 -7.953125 1.515625 -7.953125 C 1.484375 -7.953125 1.453125 -7.9375 1.40625 -7.9375 Z M 1.40625 -7.9375 "
           id="path233" />
      </g>
      <g
         id="glyph-5-12">
        <path
           d="M 0.390625 -8.171875 L 0.390625 -7.828125 L 0.609375 -7.828125 C 0.984375 -7.828125 1.296875 -7.78125 1.296875 -7.21875 L 1.296875 -0.84375 C 1.296875 -0.40625 0.984375 -0.359375 0.65625 -0.359375 L 0.390625 -0.359375 L 0.390625 -0.015625 L 2.96875 -0.015625 L 2.96875 -0.359375 L 2.671875 -0.359375 C 2.328125 -0.359375 2.0625 -0.390625 2.0625 -0.828125 L 2.0625 -8.3125 Z M 0.390625 -8.171875 "
           id="path236" />
      </g>
      <g
         id="glyph-5-13">
        <path
           d="M 0.484375 -8.171875 L 0.484375 -7.828125 L 0.890625 -7.828125 C 1.28125 -7.828125 1.640625 -7.78125 1.640625 -7.34375 C 1.640625 -7.25 1.625 -7.1875 1.625 -7.109375 L 1.625 -0.890625 C 1.625 -0.40625 1.25 -0.359375 0.859375 -0.359375 L 0.484375 -0.359375 L 0.484375 -0.015625 L 6.5 -0.015625 L 6.8125 -3.078125 L 6.546875 -3.078125 C 6.4375 -2.015625 6.328125 -0.8125 4.953125 -0.4375 C 4.609375 -0.359375 4.25 -0.359375 3.890625 -0.359375 L 3.03125 -0.359375 C 2.765625 -0.359375 2.59375 -0.4375 2.59375 -0.75 L 2.59375 -7.296875 C 2.59375 -7.765625 3.03125 -7.84375 3.453125 -7.84375 C 3.65625 -7.84375 3.859375 -7.828125 4.015625 -7.828125 L 4.015625 -8.171875 Z M 0.484375 -8.171875 "
           id="path239" />
      </g>
      <g
         id="glyph-5-14">
        <path
           d="M 0.21875 -5.15625 L 0.21875 -4.8125 L 0.375 -4.8125 C 1.015625 -4.8125 1.09375 -4.40625 1.34375 -3.609375 C 1.71875 -2.46875 2.140625 -1.34375 2.546875 -0.203125 C 2.59375 -0.078125 2.625 0.09375 2.78125 0.109375 C 2.953125 0.109375 2.984375 -0.03125 3.03125 -0.171875 L 3.359375 -1.0625 C 3.640625 -1.859375 3.890625 -2.71875 4.21875 -3.5 C 4.421875 -3.015625 4.578125 -2.5 4.75 -2 L 5.40625 -0.171875 C 5.453125 -0.03125 5.484375 0.109375 5.65625 0.109375 C 5.8125 0.09375 5.84375 -0.078125 5.890625 -0.1875 C 6.296875 -1.40625 6.75 -2.609375 7.15625 -3.796875 C 7.359375 -4.390625 7.625 -4.78125 8.21875 -4.8125 L 8.21875 -5.15625 L 6.328125 -5.15625 L 6.328125 -4.8125 C 6.640625 -4.796875 7 -4.59375 7 -4.25 C 7 -4 6.8125 -3.578125 6.6875 -3.28125 C 6.421875 -2.484375 6.09375 -1.703125 5.859375 -0.890625 L 5.84375 -0.890625 C 5.765625 -1.1875 5.640625 -1.453125 5.5625 -1.734375 C 5.265625 -2.5625 4.953125 -3.375 4.6875 -4.21875 C 4.65625 -4.296875 4.609375 -4.40625 4.609375 -4.5 L 4.609375 -4.546875 C 4.6875 -4.796875 5.015625 -4.8125 5.234375 -4.8125 L 5.296875 -4.8125 L 5.296875 -5.15625 L 3.046875 -5.15625 L 3.046875 -4.8125 L 3.21875 -4.8125 C 3.671875 -4.8125 3.84375 -4.65625 3.96875 -4.21875 C 4 -4.140625 4.0625 -4.015625 4.0625 -3.921875 L 4.0625 -3.890625 C 4.046875 -3.796875 4 -3.671875 3.953125 -3.578125 L 3.734375 -2.96875 C 3.515625 -2.3125 3.28125 -1.671875 3.0625 -1.03125 C 2.921875 -1.328125 2.828125 -1.671875 2.71875 -2 L 1.921875 -4.21875 C 1.90625 -4.296875 1.859375 -4.40625 1.859375 -4.484375 C 1.859375 -4.78125 2.28125 -4.8125 2.53125 -4.8125 L 2.53125 -5.15625 Z M 0.21875 -5.15625 "
           id="path242" />
      </g>
      <g
         id="glyph-5-15">
        <path
           d="M 1.53125 -5.140625 C 1.28125 -5.09375 1.046875 -4.875 1.046875 -4.578125 C 1.046875 -4.265625 1.296875 -4 1.609375 -4 C 1.921875 -4 2.203125 -4.234375 2.203125 -4.5625 C 2.203125 -4.875 1.9375 -5.15625 1.625 -5.15625 C 1.59375 -5.15625 1.5625 -5.140625 1.53125 -5.140625 Z M 1.53125 -1.15625 C 1.28125 -1.109375 1.046875 -0.890625 1.046875 -0.59375 C 1.046875 -0.28125 1.296875 -0.015625 1.609375 -0.015625 C 1.921875 -0.015625 2.203125 -0.25 2.203125 -0.578125 C 2.203125 -0.890625 1.9375 -1.171875 1.625 -1.171875 C 1.59375 -1.171875 1.5625 -1.15625 1.53125 -1.15625 Z M 1.53125 -1.15625 "
           id="path245" />
      </g>
      <g
         id="glyph-5-16">
        <path
           d="M 0.4375 -8.171875 L 0.4375 -7.828125 L 0.84375 -7.828125 C 1.25 -7.828125 1.625 -7.78125 1.625 -7.328125 L 1.625 -0.875 C 1.625 -0.421875 1.25 -0.34375 0.875 -0.34375 C 0.71875 -0.34375 0.5625 -0.359375 0.4375 -0.359375 L 0.4375 -0.015625 L 3.796875 -0.015625 L 3.796875 -0.359375 C 3.640625 -0.359375 3.5 -0.34375 3.359375 -0.34375 C 2.953125 -0.34375 2.59375 -0.40625 2.59375 -0.875 L 2.59375 -7.328125 C 2.59375 -7.78125 3 -7.828125 3.40625 -7.828125 L 3.796875 -7.828125 L 3.796875 -8.171875 Z M 0.4375 -8.171875 "
           id="path248" />
      </g>
      <g
         id="glyph-5-17">
        <path
           d="M 0.375 -5.140625 L 0.375 -4.796875 L 0.609375 -4.796875 C 0.953125 -4.796875 1.296875 -4.75 1.296875 -4.203125 L 1.296875 -0.859375 C 1.296875 -0.421875 1.0625 -0.359375 0.375 -0.359375 L 0.375 -0.015625 L 2.96875 -0.015625 L 2.96875 -0.359375 L 2.703125 -0.359375 C 2.359375 -0.359375 2.0625 -0.40625 2.0625 -0.84375 L 2.0625 -3.03125 C 2.0625 -3.859375 2.484375 -5.03125 3.65625 -5.03125 C 4.390625 -5.03125 4.546875 -4.328125 4.546875 -3.625 L 4.546875 -0.8125 C 4.546875 -0.390625 4.203125 -0.359375 3.84375 -0.359375 L 3.640625 -0.359375 L 3.640625 -0.015625 L 6.234375 -0.015625 L 6.234375 -0.359375 L 5.953125 -0.359375 C 5.625 -0.359375 5.3125 -0.375 5.3125 -0.828125 L 5.3125 -3.53125 C 5.3125 -3.921875 5.3125 -4.296875 5.109375 -4.625 C 4.84375 -5.109375 4.265625 -5.265625 3.75 -5.265625 C 3.171875 -5.265625 2.671875 -5.0625 2.265625 -4.5 C 2.15625 -4.34375 2.0625 -4.203125 2.015625 -4.046875 L 2.015625 -5.265625 Z M 0.375 -5.140625 "
           id="path251" />
      </g>
      <g
         id="glyph-5-18">
        <path
           d="M 0.515625 -8.171875 L 0.515625 -7.828125 L 0.90625 -7.828125 C 1.296875 -7.828125 1.65625 -7.78125 1.65625 -7.34375 C 1.65625 -7.25 1.65625 -7.1875 1.65625 -7.109375 L 1.65625 -0.890625 C 1.65625 -0.40625 1.28125 -0.359375 0.890625 -0.359375 L 0.515625 -0.359375 L 0.515625 -0.015625 L 4.125 -0.015625 C 4.34375 -0.015625 4.59375 0 4.828125 0 C 5.875 0 7.21875 -0.40625 7.546875 -1.703125 C 7.609375 -1.84375 7.625 -2.015625 7.625 -2.15625 C 7.625 -3.375 6.40625 -4.265625 5.328125 -4.265625 C 5.515625 -4.34375 5.703125 -4.359375 5.875 -4.4375 C 6.640625 -4.703125 7.296875 -5.34375 7.296875 -6.171875 C 7.296875 -7.015625 6.59375 -7.703125 5.828125 -7.984375 C 5.375 -8.15625 4.890625 -8.1875 4.40625 -8.1875 C 4.1875 -8.1875 3.953125 -8.171875 3.734375 -8.171875 Z M 2.5625 -4.140625 L 4.1875 -4.140625 C 4.34375 -4.140625 4.53125 -4.140625 4.703125 -4.140625 C 5.859375 -4.140625 6.53125 -3.21875 6.53125 -2.234375 C 6.53125 -1.078125 5.625 -0.34375 4.453125 -0.34375 C 4.265625 -0.34375 4.09375 -0.359375 3.9375 -0.359375 L 3.015625 -0.359375 C 2.6875 -0.359375 2.5625 -0.484375 2.5625 -0.796875 Z M 2.5625 -4.375 L 2.5625 -7.40625 C 2.5625 -7.703125 2.6875 -7.828125 3 -7.828125 L 4.484375 -7.828125 C 5.21875 -7.828125 5.765625 -7.578125 6.109375 -6.84375 C 6.1875 -6.640625 6.25 -6.390625 6.25 -6.15625 C 6.25 -5.015625 5.25 -4.375 4.1875 -4.375 Z M 2.5625 -4.375 "
           id="path254" />
      </g>
      <g
         id="glyph-5-19">
        <path
           d="M 0.375 -8.171875 L 0.375 -7.828125 L 0.59375 -7.828125 C 0.984375 -7.828125 1.296875 -7.78125 1.296875 -7.234375 L 1.296875 -0.84375 C 1.296875 -0.40625 0.984375 -0.359375 0.640625 -0.359375 L 0.375 -0.359375 L 0.375 -0.015625 L 2.96875 -0.015625 L 2.96875 -0.359375 L 2.703125 -0.359375 C 2.359375 -0.359375 2.0625 -0.40625 2.0625 -0.84375 L 2.0625 -3.03125 C 2.0625 -3.859375 2.484375 -5.03125 3.65625 -5.03125 C 4.390625 -5.03125 4.546875 -4.328125 4.546875 -3.625 L 4.546875 -0.8125 C 4.546875 -0.390625 4.203125 -0.359375 3.84375 -0.359375 L 3.640625 -0.359375 L 3.640625 -0.015625 L 6.234375 -0.015625 L 6.234375 -0.359375 L 5.953125 -0.359375 C 5.625 -0.359375 5.3125 -0.375 5.3125 -0.828125 L 5.3125 -3.53125 C 5.3125 -3.921875 5.3125 -4.296875 5.109375 -4.640625 C 4.828125 -5.109375 4.265625 -5.265625 3.734375 -5.265625 C 3.015625 -5.265625 2.265625 -4.828125 2.0625 -4.125 L 2.046875 -8.3125 Z M 0.375 -8.171875 "
           id="path257" />
      </g>
      <g
         id="glyph-5-20">
        <path
           d="M 0.21875 -5.15625 L 0.21875 -4.8125 L 0.4375 -4.8125 C 0.859375 -4.8125 1.046875 -4.65625 1.1875 -4.28125 L 1.4375 -3.671875 C 1.890625 -2.515625 2.34375 -1.34375 2.828125 -0.203125 C 2.875 -0.078125 2.921875 0.109375 3.078125 0.109375 C 3.25 0.109375 3.296875 -0.078125 3.34375 -0.203125 C 3.8125 -1.390625 4.28125 -2.5625 4.75 -3.734375 C 5.015625 -4.390625 5.3125 -4.8125 5.953125 -4.8125 L 5.953125 -5.15625 L 4.09375 -5.15625 L 4.09375 -4.8125 C 4.375 -4.796875 4.65625 -4.609375 4.65625 -4.296875 C 4.65625 -4.125 4.5625 -3.96875 4.5 -3.828125 C 4.265625 -3.1875 4 -2.5625 3.734375 -1.90625 L 3.5 -1.296875 C 3.453125 -1.171875 3.375 -1.046875 3.359375 -0.921875 C 3.28125 -1 3.265625 -1.125 3.234375 -1.21875 L 3 -1.765625 C 2.671875 -2.59375 2.359375 -3.421875 2.015625 -4.234375 C 1.984375 -4.3125 1.953125 -4.40625 1.953125 -4.5 L 1.953125 -4.546875 C 2.015625 -4.8125 2.359375 -4.8125 2.609375 -4.8125 L 2.609375 -5.15625 Z M 0.21875 -5.15625 "
           id="path260" />
      </g>
      <g
         id="glyph-5-21">
        <path
           d="M 2.75 -5.328125 C 1.46875 -5.21875 0.34375 -4.09375 0.34375 -2.578125 C 0.34375 -1.21875 1.34375 0.109375 2.921875 0.109375 C 4.359375 0.109375 5.484375 -1.15625 5.484375 -2.5625 C 5.484375 -3.890625 4.5 -5.34375 2.90625 -5.34375 C 2.859375 -5.34375 2.796875 -5.328125 2.75 -5.328125 Z M 1.265625 -2.3125 C 1.25 -2.40625 1.25 -2.5 1.25 -2.59375 C 1.25 -3.421875 1.34375 -4.5 2.265625 -4.9375 C 2.46875 -5.03125 2.6875 -5.078125 2.90625 -5.078125 C 3.359375 -5.078125 3.796875 -4.875 4.09375 -4.515625 C 4.515625 -4.03125 4.5625 -3.359375 4.5625 -2.734375 C 4.5625 -2.0625 4.546875 -1.296875 4.09375 -0.734375 C 3.796875 -0.375 3.359375 -0.15625 2.90625 -0.15625 C 1.90625 -0.15625 1.40625 -1.046875 1.296875 -1.9375 C 1.28125 -2.0625 1.28125 -2.1875 1.265625 -2.3125 Z M 1.265625 -2.3125 "
           id="path263" />
      </g>
      <g
         id="glyph-5-22">
        <path
           d="M 0.484375 -8.15625 L 0.484375 -7.8125 L 0.859375 -7.8125 C 1.265625 -7.8125 1.640625 -7.75 1.640625 -7.328125 C 1.640625 -7.25 1.625 -7.171875 1.625 -7.09375 L 1.625 -0.890625 C 1.625 -0.40625 1.25 -0.359375 0.859375 -0.359375 L 0.484375 -0.359375 L 0.484375 -0.015625 L 4.015625 -0.015625 L 4.015625 -0.359375 C 3.859375 -0.359375 3.6875 -0.34375 3.484375 -0.34375 C 2.921875 -0.34375 2.59375 -0.40625 2.59375 -0.921875 L 2.59375 -3.90625 L 3.59375 -3.90625 C 4.234375 -3.90625 4.90625 -3.859375 4.90625 -2.71875 L 4.90625 -2.515625 L 5.15625 -2.515625 L 5.15625 -5.65625 L 4.90625 -5.65625 L 4.90625 -5.4375 C 4.90625 -4.546875 4.578125 -4.25 3.421875 -4.25 L 2.59375 -4.25 L 2.59375 -7.375 C 2.59375 -7.703125 2.734375 -7.8125 3.0625 -7.8125 L 4.453125 -7.8125 C 5.109375 -7.8125 5.921875 -7.796875 6.390625 -7.21875 C 6.75 -6.734375 6.796875 -6.078125 6.875 -5.484375 L 7.140625 -5.484375 L 6.828125 -8.15625 Z M 0.484375 -8.15625 "
           id="path266" />
      </g>
      <g
         id="glyph-5-23">
        <path
           d="M 0.328125 -2.015625 L 3.46875 -2.015625 L 3.46875 -0.875 C 3.46875 -0.375 3.125 -0.359375 2.328125 -0.359375 L 2.328125 -0.015625 L 5.453125 -0.015625 L 5.453125 -0.359375 C 5.3125 -0.359375 5.15625 -0.34375 5.03125 -0.34375 C 4.640625 -0.34375 4.3125 -0.40625 4.3125 -0.875 L 4.3125 -2.015625 L 5.515625 -2.015625 L 5.515625 -2.359375 L 4.3125 -2.359375 L 4.3125 -7.921875 C 4.3125 -8.03125 4.25 -8.078125 4.15625 -8.078125 C 3.90625 -8.078125 3.453125 -7.203125 3.171875 -6.78125 C 2.3125 -5.4375 1.4375 -4.109375 0.578125 -2.765625 L 0.4375 -2.53125 C 0.359375 -2.421875 0.3125 -2.34375 0.3125 -2.21875 C 0.3125 -2.140625 0.328125 -2.0625 0.328125 -2.015625 Z M 0.625 -2.359375 L 3.515625 -6.84375 L 3.515625 -2.359375 Z M 0.625 -2.359375 "
           id="path269" />
      </g>
      <g
         id="glyph-5-24">
        <path
           d="M 0.921875 -1.484375 C 0.984375 -1.46875 1.046875 -1.453125 1.125 -1.453125 C 1.4375 -1.453125 1.65625 -1.6875 1.65625 -2 C 1.65625 -2.296875 1.421875 -2.515625 1.140625 -2.515625 C 0.859375 -2.515625 0.59375 -2.328125 0.578125 -2.03125 L 0.578125 -1.953125 C 0.578125 -0.8125 1.5 0.234375 2.71875 0.234375 C 4.140625 0.234375 5.25 -1.015625 5.25 -2.453125 C 5.25 -3.640625 4.453125 -4.9375 3.171875 -5.015625 L 3.0625 -5.015625 C 2.53125 -5.015625 1.8125 -4.8125 1.53125 -4.375 L 1.515625 -6.859375 C 1.859375 -6.75 2.21875 -6.6875 2.5625 -6.6875 C 3.34375 -6.6875 4.09375 -7 4.671875 -7.625 C 4.71875 -7.703125 4.796875 -7.75 4.796875 -7.84375 L 4.796875 -7.859375 C 4.78125 -7.921875 4.734375 -7.953125 4.6875 -7.953125 C 4.5 -7.953125 4.25 -7.78125 4.046875 -7.71875 C 3.71875 -7.625 3.359375 -7.578125 3.015625 -7.578125 C 2.46875 -7.578125 2.015625 -7.703125 1.5 -7.875 C 1.453125 -7.90625 1.390625 -7.9375 1.328125 -7.953125 L 1.296875 -7.953125 C 1.25 -7.953125 1.203125 -7.90625 1.1875 -7.84375 L 1.1875 -4.046875 C 1.1875 -3.9375 1.21875 -3.84375 1.34375 -3.84375 C 1.5 -3.84375 1.5625 -4.078125 1.65625 -4.171875 C 2.015625 -4.546875 2.5 -4.78125 3.015625 -4.78125 L 3.078125 -4.78125 C 4.09375 -4.734375 4.28125 -3.375 4.28125 -2.5 C 4.28125 -1.671875 4.203125 -0.640625 3.28125 -0.21875 C 3.078125 -0.125 2.875 -0.078125 2.671875 -0.078125 C 1.890625 -0.078125 1.109375 -0.71875 0.921875 -1.484375 Z M 0.921875 -1.484375 "
           id="path272" />
      </g>
      <g
         id="glyph-5-25">
        <path
           d="M 0.125 -2.90625 L 0.125 -2.265625 L 3.234375 -2.265625 L 3.234375 -2.90625 Z M 0.125 -2.90625 "
           id="path275" />
      </g>
      <g
         id="glyph-6-0" />
      <g
         id="glyph-6-1">
        <path
           d="M 3.359375 -5.34375 C 3.03125 -4.984375 2.78125 -4.984375 2.6875 -4.984375 C 2.515625 -4.984375 2.34375 -5.0625 2.15625 -5.171875 C 1.9375 -5.28125 1.796875 -5.34375 1.609375 -5.34375 C 1.296875 -5.34375 1.140625 -5.171875 0.703125 -4.703125 L 0.875 -4.5625 C 1.1875 -4.921875 1.4375 -4.921875 1.53125 -4.921875 C 1.71875 -4.921875 1.875 -4.84375 2.078125 -4.734375 C 2.28125 -4.625 2.4375 -4.5625 2.609375 -4.5625 C 2.921875 -4.5625 3.078125 -4.71875 3.515625 -5.203125 Z M 3.359375 -5.34375 "
           id="path279" />
      </g>
      <g
         id="glyph-7-0" />
      <g
         id="glyph-7-1">
        <path
           d="M 6.078125 -3.234375 C 5.421875 -4.046875 5.28125 -4.234375 4.90625 -4.53125 C 4.25 -5.0625 3.578125 -5.28125 2.96875 -5.28125 C 1.5625 -5.28125 0.65625 -3.96875 0.65625 -2.5625 C 0.65625 -1.1875 1.546875 0.125 2.921875 0.125 C 4.296875 0.125 5.28125 -0.953125 5.875 -1.90625 C 6.515625 -1.09375 6.65625 -0.921875 7.03125 -0.625 C 7.703125 -0.078125 8.359375 0.125 8.984375 0.125 C 10.375 0.125 11.28125 -1.1875 11.28125 -2.578125 C 11.28125 -3.953125 10.40625 -5.28125 9.03125 -5.28125 C 7.65625 -5.28125 6.65625 -4.203125 6.078125 -3.234375 Z M 6.390625 -2.828125 C 6.875 -3.6875 7.75 -4.90625 9.109375 -4.90625 C 10.375 -4.90625 11.015625 -3.65625 11.015625 -2.578125 C 11.015625 -1.40625 10.21875 -0.4375 9.171875 -0.4375 C 8.46875 -0.4375 7.9375 -0.9375 7.6875 -1.1875 C 7.390625 -1.515625 7.109375 -1.890625 6.390625 -2.828125 Z M 5.5625 -2.3125 C 5.0625 -1.453125 4.1875 -0.25 2.828125 -0.25 C 1.5625 -0.25 0.921875 -1.5 0.921875 -2.5625 C 0.921875 -3.734375 1.71875 -4.703125 2.765625 -4.703125 C 3.46875 -4.703125 4 -4.203125 4.25 -3.953125 C 4.546875 -3.640625 4.828125 -3.265625 5.5625 -2.3125 Z M 5.5625 -2.3125 "
           id="path283" />
      </g>
      <g
         id="glyph-7-2">
        <path
           d="M 9.96875 -2.75 C 9.3125 -2.25 8.984375 -1.75 8.890625 -1.609375 C 8.359375 -0.78125 8.265625 -0.03125 8.265625 -0.015625 C 8.265625 0.125 8.40625 0.125 8.5 0.125 C 8.703125 0.125 8.71875 0.109375 8.765625 -0.109375 C 9.03125 -1.28125 9.734375 -2.28125 11.09375 -2.828125 C 11.234375 -2.875 11.265625 -2.90625 11.265625 -2.984375 C 11.265625 -3.078125 11.203125 -3.109375 11.171875 -3.125 C 10.65625 -3.328125 9.203125 -3.921875 8.75 -5.921875 C 8.71875 -6.078125 8.703125 -6.109375 8.5 -6.109375 C 8.40625 -6.109375 8.265625 -6.109375 8.265625 -5.96875 C 8.265625 -5.9375 8.359375 -5.1875 8.875 -4.390625 C 9.109375 -4.03125 9.453125 -3.609375 9.96875 -3.234375 L 1.09375 -3.234375 C 0.875 -3.234375 0.65625 -3.234375 0.65625 -2.984375 C 0.65625 -2.75 0.875 -2.75 1.09375 -2.75 Z M 9.96875 -2.75 "
           id="path286" />
      </g>
      <g
         id="glyph-8-0" />
      <g
         id="glyph-8-1">
        <path
           d="M 4.296875 -2.1875 C 3.828125 -2.75 3.765625 -2.8125 3.484375 -3.015625 C 3.125 -3.296875 2.640625 -3.515625 2.109375 -3.515625 C 1.140625 -3.515625 0.46875 -2.65625 0.46875 -1.71875 C 0.46875 -0.78125 1.125 0.078125 2.078125 0.078125 C 2.734375 0.078125 3.5 -0.265625 4.15625 -1.25 C 4.625 -0.6875 4.6875 -0.625 4.96875 -0.421875 C 5.34375 -0.140625 5.828125 0.078125 6.34375 0.078125 C 7.328125 0.078125 8 -0.765625 8 -1.71875 C 8 -2.65625 7.328125 -3.515625 6.390625 -3.515625 C 5.734375 -3.515625 4.96875 -3.171875 4.296875 -2.1875 Z M 4.546875 -1.890625 C 4.84375 -2.390625 5.5 -3.21875 6.4375 -3.21875 C 7.296875 -3.21875 7.765625 -2.4375 7.765625 -1.71875 C 7.765625 -0.953125 7.1875 -0.34375 6.484375 -0.34375 C 5.78125 -0.34375 5.3125 -0.9375 4.546875 -1.890625 Z M 3.921875 -1.546875 C 3.625 -1.046875 2.96875 -0.21875 2.03125 -0.21875 C 1.171875 -0.21875 0.6875 -1 0.6875 -1.71875 C 0.6875 -2.484375 1.28125 -3.078125 1.984375 -3.078125 C 2.6875 -3.078125 3.15625 -2.5 3.921875 -1.546875 Z M 3.921875 -1.546875 "
           id="path290" />
      </g>
      <g
         id="glyph-9-0" />
      <g
         id="glyph-9-1">
        <path
           d="M 0.390625 -6.78125 L 0.390625 -6.3125 L 1.46875 -6.3125 L 1.46875 -0.484375 L 0.390625 -0.484375 L 0.390625 -0.015625 L 4.234375 -0.015625 L 4.234375 -0.484375 L 2.875 -0.484375 L 2.875 -3.171875 L 3.328125 -3.171875 C 3.9375 -3.171875 4.421875 -3.125 4.421875 -2 L 4.890625 -2 L 4.890625 -4.8125 L 4.421875 -4.8125 L 4.421875 -4.6875 C 4.421875 -3.71875 3.90625 -3.640625 3.328125 -3.640625 L 2.875 -3.640625 L 2.875 -6.3125 L 4.046875 -6.3125 C 4.75 -6.3125 5.5 -6.3125 5.9375 -5.578125 C 6.140625 -5.21875 6.1875 -4.796875 6.25 -4.390625 L 6.71875 -4.390625 L 6.40625 -6.78125 Z M 0.390625 -6.78125 "
           id="path294" />
      </g>
      <g
         id="glyph-9-2">
        <path
           d="M 0.5 -4.421875 L 0.5 -3.953125 C 0.578125 -3.953125 0.671875 -3.953125 0.75 -3.953125 C 0.953125 -3.953125 1.15625 -3.90625 1.15625 -3.625 L 1.15625 -0.484375 L 0.46875 -0.484375 L 0.46875 -0.015625 L 2.84375 -0.015625 L 2.84375 -0.484375 L 2.234375 -0.484375 L 2.234375 -4.5 L 1.09375 -4.5 Z M 1.453125 -6.921875 C 1.078125 -6.890625 0.78125 -6.546875 0.78125 -6.15625 C 0.78125 -5.765625 1.078125 -5.390625 1.5625 -5.390625 C 1.953125 -5.390625 2.328125 -5.71875 2.328125 -6.15625 C 2.328125 -6.546875 2.03125 -6.9375 1.5625 -6.9375 C 1.53125 -6.9375 1.484375 -6.9375 1.453125 -6.921875 Z M 1.453125 -6.921875 "
           id="path297" />
      </g>
      <g
         id="glyph-9-3">
        <path
           d="M 1.078125 -1.96875 C 0.875 -1.6875 0.75 -1.421875 0.75 -1.0625 C 0.75 -0.734375 0.875 -0.3125 1.171875 -0.125 C 0.78125 -0.078125 0.3125 0.296875 0.3125 0.734375 C 0.3125 1.890625 2.21875 2 2.78125 2 C 3.71875 2 5.40625 1.859375 5.40625 0.6875 C 5.40625 0.15625 5.140625 -0.3125 4.671875 -0.5625 C 4.109375 -0.84375 3.453125 -0.84375 2.84375 -0.84375 L 1.8125 -0.84375 C 1.5 -0.875 1.234375 -1.140625 1.234375 -1.453125 L 1.234375 -1.46875 C 1.234375 -1.59375 1.28125 -1.6875 1.328125 -1.796875 C 1.6875 -1.609375 2.125 -1.546875 2.53125 -1.546875 C 3.4375 -1.546875 4.53125 -1.9375 4.53125 -3.03125 C 4.53125 -3.390625 4.359375 -3.71875 4.125 -3.984375 C 4.328125 -4.0625 4.53125 -4.15625 4.75 -4.171875 C 4.71875 -4.09375 4.703125 -4.015625 4.703125 -3.953125 C 4.703125 -3.703125 4.890625 -3.53125 5.140625 -3.53125 C 5.359375 -3.53125 5.5625 -3.703125 5.5625 -3.96875 C 5.5625 -4.3125 5.25 -4.5625 4.921875 -4.5625 C 4.578125 -4.5625 4.28125 -4.421875 4.03125 -4.28125 C 3.984375 -4.25 3.9375 -4.203125 3.875 -4.1875 C 3.8125 -4.1875 3.765625 -4.234375 3.734375 -4.25 C 3.328125 -4.4375 2.953125 -4.5 2.53125 -4.5 L 2.375 -4.5 C 1.53125 -4.46875 0.5625 -4.015625 0.5625 -3.015625 C 0.5625 -2.65625 0.75 -2.15625 1.078125 -1.96875 Z M 1.171875 0.78125 L 1.171875 0.734375 C 1.171875 0.265625 1.5625 0.125 2.03125 0.125 L 3.078125 0.125 C 3.5625 0.125 4.453125 0.125 4.546875 0.6875 L 4.546875 0.734375 C 4.546875 1.625 3.015625 1.640625 2.8125 1.640625 C 2.21875 1.640625 1.28125 1.46875 1.171875 0.78125 Z M 1.671875 -2.765625 L 1.671875 -3.078125 C 1.671875 -3.5625 1.75 -4.140625 2.546875 -4.140625 C 3.15625 -4.140625 3.421875 -3.78125 3.421875 -2.984375 C 3.421875 -2.703125 3.421875 -2.375 3.203125 -2.15625 C 3.046875 -1.984375 2.796875 -1.90625 2.546875 -1.90625 C 2 -1.90625 1.71875 -2.21875 1.671875 -2.765625 Z M 1.671875 -2.765625 "
           id="path300" />
      </g>
      <g
         id="glyph-9-4">
        <path
           d="M 0.453125 -4.421875 L 0.453125 -3.953125 L 0.671875 -3.953125 C 0.859375 -3.953125 1.109375 -3.9375 1.140625 -3.71875 L 1.140625 -1.28125 C 1.140625 -0.0625 2.125 0.046875 2.90625 0.046875 C 3.453125 0.046875 4.046875 -0.125 4.359375 -0.734375 L 4.359375 0.046875 L 6.125 0.046875 L 6.125 -0.484375 L 5.90625 -0.484375 C 5.671875 -0.484375 5.4375 -0.515625 5.4375 -0.796875 L 5.4375 -4.5 L 4 -4.5 L 3.625 -4.421875 L 3.625 -3.953125 L 3.828125 -3.953125 C 4.09375 -3.953125 4.3125 -3.921875 4.3125 -3.625 L 4.3125 -1.6875 C 4.3125 -1 3.90625 -0.3125 3.109375 -0.3125 L 3.015625 -0.3125 C 2.703125 -0.3125 2.328125 -0.328125 2.28125 -0.875 C 2.265625 -1.0625 2.265625 -1.28125 2.265625 -1.46875 L 2.265625 -4.5 L 0.84375 -4.5 Z M 0.453125 -4.421875 "
           id="path303" />
      </g>
      <g
         id="glyph-9-5">
        <path
           d="M 0.359375 -4.421875 L 0.359375 -3.953125 L 0.5625 -3.953125 C 0.8125 -3.953125 1.046875 -3.921875 1.046875 -3.625 L 1.046875 -0.484375 L 0.359375 -0.484375 L 0.359375 -0.015625 L 2.984375 -0.015625 L 2.984375 -0.484375 L 2.125 -0.484375 L 2.125 -1.859375 C 2.125 -2.71875 2.21875 -4.140625 3.375 -4.140625 C 3.25 -4 3.1875 -3.84375 3.1875 -3.671875 C 3.1875 -3.328125 3.453125 -3.078125 3.78125 -3.078125 C 4.125 -3.078125 4.390625 -3.34375 4.390625 -3.671875 C 4.390625 -4.234375 3.828125 -4.5 3.34375 -4.5 C 2.75 -4.5 2.15625 -4.03125 2.03125 -3.375 L 2.015625 -4.5 L 0.921875 -4.453125 Z M 0.359375 -4.421875 "
           id="path306" />
      </g>
      <g
         id="glyph-9-6">
        <path
           d="M 1.59375 -2.1875 L 4.671875 -2.1875 C 4.84375 -2.1875 4.921875 -2.25 4.921875 -2.421875 C 4.921875 -3.421875 4.453125 -4.53125 2.78125 -4.53125 C 2.15625 -4.53125 1.53125 -4.359375 1.0625 -3.953125 C 0.5625 -3.53125 0.3125 -2.890625 0.3125 -2.25 C 0.3125 -1.640625 0.53125 -1.078125 0.953125 -0.640625 C 1.46875 -0.140625 2.21875 0.046875 2.9375 0.046875 C 3.625 0.046875 4.40625 -0.203125 4.78125 -0.828125 C 4.84375 -0.921875 4.921875 -1.0625 4.921875 -1.1875 C 4.921875 -1.3125 4.796875 -1.359375 4.6875 -1.359375 C 4.46875 -1.359375 4.453125 -1.15625 4.34375 -0.984375 C 4.078125 -0.5625 3.53125 -0.34375 3.03125 -0.34375 C 2.546875 -0.34375 2.078125 -0.546875 1.828125 -0.984375 C 1.609375 -1.328125 1.59375 -1.78125 1.59375 -2.1875 Z M 1.59375 -2.515625 C 1.59375 -3.1875 1.78125 -4.171875 2.796875 -4.171875 C 3.71875 -4.171875 3.984375 -3.25 3.984375 -2.515625 Z M 1.59375 -2.515625 "
           id="path309" />
      </g>
      <g
         id="glyph-9-7">
        <path
           d="M 1.25 -0.953125 C 1.625 -0.984375 1.90625 -1.21875 1.90625 -1.609375 C 1.90625 -1.953125 1.65625 -2.296875 1.25 -2.296875 C 0.828125 -2.296875 0.5625 -1.96875 0.5625 -1.5625 C 0.5625 -0.5 1.65625 0.09375 2.578125 0.09375 C 3.84375 0.09375 5.15625 -0.546875 5.15625 -2.046875 C 5.15625 -2.578125 4.96875 -3.109375 4.578125 -3.484375 C 4.140625 -3.90625 3.53125 -4.09375 2.921875 -4.09375 C 2.46875 -4.09375 1.984375 -4 1.59375 -3.734375 L 1.59375 -5.046875 C 1.84375 -5.03125 2.09375 -4.984375 2.359375 -4.984375 C 3.203125 -5 4.125 -5.421875 4.59375 -6.125 C 4.65625 -6.1875 4.703125 -6.28125 4.703125 -6.375 C 4.703125 -6.46875 4.640625 -6.546875 4.5625 -6.546875 C 4.484375 -6.546875 4.40625 -6.484375 4.328125 -6.453125 C 3.859375 -6.3125 3.390625 -6.21875 2.890625 -6.21875 C 2.375 -6.21875 1.890625 -6.3125 1.40625 -6.484375 C 1.34375 -6.5 1.28125 -6.53125 1.21875 -6.546875 C 1.140625 -6.546875 1.078125 -6.46875 1.0625 -6.390625 L 1.0625 -3.34375 C 1.0625 -3.203125 1.078125 -3.046875 1.28125 -3.046875 C 1.484375 -3.046875 1.59375 -3.265625 1.75 -3.390625 C 2.046875 -3.625 2.46875 -3.734375 2.828125 -3.734375 C 3.734375 -3.734375 3.734375 -2.75 3.734375 -1.984375 L 3.734375 -1.890625 C 3.734375 -1.515625 3.734375 -1.125 3.53125 -0.8125 C 3.3125 -0.46875 2.921875 -0.328125 2.53125 -0.328125 C 2.015625 -0.328125 1.578125 -0.546875 1.25 -0.953125 Z M 1.25 -0.953125 "
           id="path312" />
      </g>
      <g
         id="glyph-9-8">
        <path
           d="M 1.484375 -1.5625 C 1.078125 -1.53125 0.8125 -1.140625 0.8125 -0.78125 C 0.8125 -0.421875 1.09375 -0.015625 1.578125 -0.015625 C 2.046875 -0.015625 2.359375 -0.390625 2.359375 -0.796875 C 2.359375 -1.15625 2.078125 -1.5625 1.59375 -1.5625 C 1.5625 -1.5625 1.515625 -1.5625 1.484375 -1.5625 Z M 1.484375 -1.5625 "
           id="path315" />
      </g>
      <g
         id="glyph-9-9">
        <path
           d="M 0.84375 -5.90625 L 0.84375 -5.4375 C 1.328125 -5.4375 1.890625 -5.46875 2.34375 -5.625 L 2.34375 -0.484375 L 0.953125 -0.484375 L 0.953125 -0.015625 L 4.921875 -0.015625 L 4.921875 -0.484375 L 3.53125 -0.484375 L 3.53125 -6.265625 C 3.53125 -6.421875 3.5 -6.546875 3.265625 -6.546875 C 3.109375 -6.546875 3.015625 -6.453125 2.90625 -6.375 C 2.265625 -5.984375 1.5625 -5.90625 0.84375 -5.90625 Z M 0.84375 -5.90625 "
           id="path318" />
      </g>
      <g
         id="glyph-9-10">
        <path
           d="M 1.484375 -4.421875 C 1.078125 -4.390625 0.8125 -4 0.8125 -3.65625 C 0.8125 -3.296875 1.09375 -2.875 1.578125 -2.875 C 2.046875 -2.875 2.359375 -3.265625 2.359375 -3.671875 C 2.359375 -4.03125 2.078125 -4.4375 1.59375 -4.4375 C 1.5625 -4.4375 1.515625 -4.4375 1.484375 -4.421875 Z M 1.484375 -1.5625 C 1.078125 -1.53125 0.8125 -1.140625 0.8125 -0.78125 C 0.8125 -0.421875 1.09375 -0.015625 1.578125 -0.015625 C 2.046875 -0.015625 2.359375 -0.390625 2.359375 -0.796875 C 2.359375 -1.15625 2.078125 -1.5625 1.59375 -1.5625 C 1.5625 -1.5625 1.515625 -1.5625 1.484375 -1.5625 Z M 1.484375 -1.5625 "
           id="path321" />
      </g>
      <g
         id="glyph-10-0" />
      <g
         id="glyph-10-1">
        <path
           d="M 0.359375 -6.8125 L 0.359375 -6.515625 C 0.484375 -6.515625 0.625 -6.515625 0.734375 -6.515625 C 1.09375 -6.515625 1.390625 -6.46875 1.390625 -6.078125 L 1.390625 -0.75 C 1.390625 -0.375 1.0625 -0.3125 0.71875 -0.3125 C 0.59375 -0.3125 0.46875 -0.3125 0.359375 -0.3125 L 0.359375 -0.015625 L 3.5 -0.015625 C 3.703125 -0.015625 3.90625 0 4.109375 0 C 5.1875 0 6.5 -0.5 6.5 -1.890625 C 6.5 -2.84375 5.375 -3.5625 4.5625 -3.5625 L 4.5625 -3.578125 C 5.3125 -3.65625 6.21875 -4.28125 6.21875 -5.140625 L 6.21875 -5.203125 C 6.140625 -6.34375 4.859375 -6.828125 3.859375 -6.828125 C 3.65625 -6.828125 3.453125 -6.8125 3.265625 -6.8125 Z M 2.21875 -3.4375 L 4 -3.4375 C 4.96875 -3.4375 5.5 -2.703125 5.5 -1.875 C 5.5 -0.984375 4.859375 -0.3125 3.84375 -0.3125 C 3.671875 -0.3125 3.515625 -0.3125 3.359375 -0.3125 L 2.59375 -0.3125 C 2.375 -0.3125 2.21875 -0.375 2.21875 -0.640625 Z M 2.21875 -3.65625 L 2.21875 -6.140625 C 2.21875 -6.4375 2.359375 -6.484375 2.578125 -6.515625 L 3.84375 -6.515625 C 4.421875 -6.515625 4.859375 -6.296875 5.140625 -5.71875 C 5.203125 -5.53125 5.25 -5.328125 5.25 -5.125 C 5.25 -4.25 4.46875 -3.65625 3.625 -3.65625 C 3.515625 -3.65625 3.40625 -3.65625 3.296875 -3.65625 Z M 2.21875 -3.65625 "
           id="path325" />
      </g>
      <g
         id="glyph-10-2">
        <path
           d="M 1.109375 -2.3125 L 3.984375 -2.3125 C 4.09375 -2.3125 4.140625 -2.375 4.140625 -2.5 C 4.140625 -3.546875 3.5 -4.46875 2.375 -4.46875 C 1.15625 -4.46875 0.28125 -3.375 0.28125 -2.1875 C 0.28125 -1.28125 0.78125 -0.453125 1.671875 -0.0625 C 1.890625 0.046875 2.15625 0.09375 2.40625 0.09375 L 2.4375 0.09375 C 3.203125 0.09375 3.84375 -0.328125 4.109375 -1.09375 C 4.125 -1.125 4.125 -1.171875 4.125 -1.203125 C 4.125 -1.265625 4.09375 -1.3125 4.015625 -1.3125 C 3.875 -1.3125 3.8125 -0.984375 3.75 -0.875 C 3.5 -0.4375 3.015625 -0.15625 2.5 -0.15625 C 2.140625 -0.15625 1.8125 -0.359375 1.546875 -0.625 C 1.140625 -1.09375 1.109375 -1.734375 1.109375 -2.3125 Z M 1.125 -2.515625 C 1.125 -3.296875 1.53125 -4.25 2.359375 -4.25 L 2.40625 -4.25 C 3.375 -4.15625 3.375 -3.125 3.46875 -2.515625 Z M 1.125 -2.515625 "
           id="path328" />
      </g>
      <g
         id="glyph-10-3">
        <path
           d="M 0.3125 -6.8125 L 0.3125 -6.515625 L 0.46875 -6.515625 C 0.84375 -6.515625 1.09375 -6.46875 1.09375 -5.984375 L 1.09375 -0.953125 C 1.09375 -0.890625 1.109375 -0.8125 1.109375 -0.734375 C 1.109375 -0.359375 0.84375 -0.3125 0.5625 -0.3125 L 0.3125 -0.3125 L 0.3125 -0.015625 L 2.578125 -0.015625 L 2.578125 -0.3125 L 2.3125 -0.3125 C 2.03125 -0.3125 1.796875 -0.359375 1.796875 -0.734375 L 1.796875 -2.546875 C 1.796875 -3.265625 2.15625 -4.1875 3.15625 -4.1875 C 3.78125 -4.1875 3.84375 -3.5 3.84375 -3.078125 L 3.84375 -0.6875 C 3.84375 -0.34375 3.5625 -0.3125 3.25 -0.3125 L 3.078125 -0.3125 L 3.078125 -0.015625 L 5.328125 -0.015625 L 5.328125 -0.3125 L 5.078125 -0.3125 C 4.8125 -0.3125 4.546875 -0.359375 4.546875 -0.703125 L 4.546875 -2.875 C 4.546875 -3.203125 4.53125 -3.53125 4.390625 -3.84375 C 4.140625 -4.28125 3.65625 -4.40625 3.1875 -4.40625 C 2.609375 -4.40625 1.96875 -4.015625 1.78125 -3.453125 L 1.765625 -6.921875 Z M 0.3125 -6.8125 "
           id="path331" />
      </g>
      <g
         id="glyph-10-4">
        <path
           d="M 1.109375 -3.796875 C 1.359375 -4.109375 1.796875 -4.25 2.171875 -4.25 C 2.90625 -4.25 3.234375 -3.578125 3.234375 -2.875 L 3.234375 -2.609375 C 2.09375 -2.609375 0.40625 -2.25 0.40625 -0.953125 L 0.40625 -0.875 C 0.484375 -0.09375 1.453125 0.09375 2.03125 0.09375 C 2.53125 0.09375 3.1875 -0.234375 3.3125 -0.75 C 3.375 -0.3125 3.65625 0.046875 4.09375 0.046875 C 4.5 0.046875 4.859375 -0.28125 4.921875 -0.734375 L 4.921875 -1.453125 L 4.671875 -1.453125 L 4.671875 -0.953125 C 4.671875 -0.671875 4.609375 -0.265625 4.3125 -0.265625 C 3.984375 -0.265625 3.9375 -0.65625 3.9375 -0.921875 L 3.9375 -2.59375 C 3.9375 -2.71875 3.953125 -2.84375 3.953125 -2.96875 C 3.953125 -3.9375 3.046875 -4.46875 2.21875 -4.46875 C 1.578125 -4.46875 0.703125 -4.15625 0.703125 -3.359375 C 0.703125 -3.078125 0.90625 -2.875 1.171875 -2.875 C 1.453125 -2.875 1.609375 -3.09375 1.609375 -3.34375 C 1.609375 -3.625 1.390625 -3.796875 1.109375 -3.796875 Z M 3.234375 -2.40625 L 3.234375 -1.390625 C 3.234375 -0.703125 2.765625 -0.15625 2.109375 -0.125 L 2.078125 -0.125 C 1.609375 -0.125 1.1875 -0.484375 1.1875 -0.96875 L 1.1875 -1.015625 C 1.25 -2.03125 2.375 -2.375 3.234375 -2.40625 Z M 3.234375 -2.40625 "
           id="path334" />
      </g>
      <g
         id="glyph-10-5">
        <path
           d="M 0.1875 -4.296875 L 0.1875 -3.984375 L 0.375 -3.984375 C 0.875 -3.984375 0.921875 -3.78125 1.21875 -3.03125 L 2.03125 -1.03125 C 2.1875 -0.640625 2.390625 0.09375 2.625 0.09375 C 2.859375 0.09375 3.046875 -0.625 3.203125 -0.984375 L 4.03125 -3.046875 C 4.28125 -3.671875 4.5 -3.984375 5.0625 -3.984375 L 5.0625 -4.296875 L 3.453125 -4.296875 L 3.453125 -3.984375 C 3.671875 -3.984375 3.921875 -3.8125 3.921875 -3.578125 C 3.921875 -3.453125 3.875 -3.3125 3.8125 -3.1875 C 3.53125 -2.46875 3.25 -1.78125 2.953125 -1.078125 C 2.9375 -0.984375 2.875 -0.890625 2.859375 -0.796875 L 2.84375 -0.796875 C 2.78125 -1.03125 2.671875 -1.25 2.578125 -1.484375 L 1.765625 -3.5 C 1.734375 -3.578125 1.6875 -3.65625 1.6875 -3.734375 L 1.6875 -3.78125 C 1.75 -3.984375 2.046875 -3.984375 2.25 -3.984375 L 2.25 -4.296875 Z M 0.1875 -4.296875 "
           id="path337" />
      </g>
      <g
         id="glyph-10-6">
        <path
           d="M 0.375 -4.296875 L 0.375 -3.984375 L 0.5625 -3.984375 C 0.84375 -3.984375 1.109375 -3.953125 1.109375 -3.484375 L 1.109375 -0.734375 C 1.109375 -0.375 0.921875 -0.3125 0.328125 -0.3125 L 0.328125 -0.015625 L 2.46875 -0.015625 L 2.46875 -0.3125 L 2.265625 -0.3125 C 2.015625 -0.3125 1.78125 -0.34375 1.78125 -0.671875 L 1.78125 -4.40625 Z M 1.203125 -6.671875 C 0.953125 -6.640625 0.75 -6.421875 0.75 -6.15625 C 0.75 -5.859375 1 -5.625 1.28125 -5.625 C 1.5625 -5.625 1.8125 -5.84375 1.8125 -6.15625 C 1.8125 -6.4375 1.5625 -6.671875 1.28125 -6.671875 C 1.25 -6.671875 1.234375 -6.671875 1.203125 -6.671875 Z M 1.203125 -6.671875 "
           id="path340" />
      </g>
      <g
         id="glyph-10-7">
        <path
           d="M 2.34375 -4.46875 C 1.09375 -4.34375 0.28125 -3.28125 0.28125 -2.125 C 0.28125 -1 1.171875 0.09375 2.5 0.09375 C 3.6875 0.09375 4.6875 -0.875 4.6875 -2.140625 C 4.6875 -3.3125 3.796875 -4.46875 2.46875 -4.46875 C 2.4375 -4.46875 2.375 -4.46875 2.34375 -4.46875 Z M 1.109375 -1.890625 L 1.109375 -2.328125 C 1.109375 -3.09375 1.359375 -4.25 2.484375 -4.25 C 3.296875 -4.25 3.75 -3.5625 3.84375 -2.8125 C 3.859375 -2.59375 3.859375 -2.375 3.859375 -2.15625 C 3.859375 -1.515625 3.78125 -0.703125 3.15625 -0.34375 C 2.953125 -0.203125 2.734375 -0.15625 2.5 -0.15625 C 1.78125 -0.15625 1.265625 -0.71875 1.15625 -1.5 C 1.140625 -1.625 1.140625 -1.765625 1.109375 -1.890625 Z M 1.109375 -1.890625 "
           id="path343" />
      </g>
      <g
         id="glyph-10-8">
        <path
           d="M 0.265625 -4.296875 L 0.265625 -3.984375 L 0.421875 -3.984375 C 0.75 -3.984375 1.046875 -3.953125 1.046875 -3.484375 L 1.046875 -0.734375 C 1.046875 -0.328125 0.765625 -0.3125 0.328125 -0.3125 L 0.265625 -0.3125 L 0.265625 -0.015625 L 2.6875 -0.015625 L 2.6875 -0.3125 C 2.5625 -0.3125 2.421875 -0.3125 2.296875 -0.3125 C 1.984375 -0.3125 1.71875 -0.359375 1.71875 -0.734375 L 1.71875 -2.046875 C 1.71875 -2.90625 1.90625 -4.1875 2.890625 -4.1875 C 2.9375 -4.1875 2.953125 -4.1875 3 -4.171875 C 2.84375 -4.109375 2.765625 -3.953125 2.765625 -3.78125 C 2.765625 -3.5625 2.921875 -3.40625 3.15625 -3.359375 C 3.4375 -3.359375 3.625 -3.53125 3.625 -3.78125 C 3.625 -4.1875 3.25 -4.40625 2.890625 -4.40625 C 2.296875 -4.40625 1.78125 -3.875 1.671875 -3.34375 L 1.671875 -4.40625 Z M 0.265625 -4.296875 "
           id="path346" />
      </g>
      <g
         id="glyph-10-9">
        <path
           d="M 1.109375 -4.296875 L 0.328125 -4.296875 L 0.328125 -3.984375 L 1.109375 -3.984375 L 1.109375 -0.6875 C 1.109375 -0.34375 0.8125 -0.3125 0.515625 -0.3125 L 0.34375 -0.3125 L 0.34375 -0.015625 L 2.734375 -0.015625 L 2.734375 -0.3125 L 2.421875 -0.3125 C 2.203125 -0.3125 1.96875 -0.328125 1.859375 -0.4375 C 1.78125 -0.53125 1.78125 -0.65625 1.78125 -0.78125 L 1.78125 -3.984375 L 2.90625 -3.984375 L 2.90625 -4.296875 L 1.75 -4.296875 L 1.75 -5.609375 C 1.75 -6.15625 2.125 -6.8125 2.65625 -6.8125 C 2.765625 -6.8125 2.90625 -6.796875 2.984375 -6.734375 C 2.796875 -6.6875 2.6875 -6.515625 2.6875 -6.3125 C 2.6875 -6.0625 2.875 -5.890625 3.125 -5.890625 C 3.375 -5.890625 3.5625 -6.09375 3.5625 -6.3125 C 3.5625 -6.78125 3.078125 -7.03125 2.65625 -7.03125 C 1.75 -7.03125 1.109375 -6.328125 1.109375 -5.359375 Z M 1.109375 -4.296875 "
           id="path349" />
      </g>
      <g
         id="glyph-10-10">
        <path
           d="M 1.484375 -6.140625 C 1.484375 -5.453125 1.203125 -4.203125 0.171875 -4.203125 L 0.171875 -3.984375 L 1.03125 -3.984375 L 1.03125 -1.421875 C 1.03125 -1.09375 1.0625 -0.75 1.21875 -0.46875 C 1.4375 -0.0625 1.90625 0.09375 2.34375 0.09375 C 3.15625 0.09375 3.3125 -0.8125 3.3125 -1.453125 L 3.3125 -1.8125 L 3.078125 -1.8125 C 3.078125 -1.671875 3.078125 -1.515625 3.078125 -1.359375 C 3.078125 -0.921875 2.984375 -0.15625 2.390625 -0.15625 C 1.828125 -0.15625 1.734375 -0.84375 1.734375 -1.28125 L 1.734375 -3.984375 L 3.15625 -3.984375 L 3.15625 -4.296875 L 1.734375 -4.296875 L 1.734375 -6.140625 Z M 1.484375 -6.140625 "
           id="path352" />
      </g>
      <g
         id="glyph-10-11">
        <path
           d="M 0.375 -6.8125 L 0.375 -6.515625 C 0.5 -6.515625 0.625 -6.515625 0.75 -6.515625 C 1.109375 -6.515625 1.390625 -6.46875 1.390625 -6.078125 L 1.390625 -1.03125 C 1.390625 -0.375 0.796875 -0.3125 0.375 -0.3125 L 0.375 -0.015625 L 2.703125 -0.015625 L 2.703125 -0.3125 C 2.25 -0.3125 1.671875 -0.375 1.671875 -1.0625 C 1.671875 -1.15625 1.671875 -1.25 1.671875 -1.34375 L 1.6875 -6.453125 C 1.734375 -6.234375 1.828125 -6.046875 1.90625 -5.84375 C 2.609375 -4 3.328125 -2.15625 4.046875 -0.34375 C 4.09375 -0.234375 4.140625 -0.015625 4.28125 -0.015625 L 4.296875 -0.015625 C 4.453125 -0.03125 4.484375 -0.265625 4.53125 -0.375 C 5.25 -2.25 6 -4.125 6.703125 -6 C 6.78125 -6.171875 6.859375 -6.34375 6.90625 -6.515625 L 6.921875 -0.765625 C 6.921875 -0.375 6.59375 -0.3125 6.28125 -0.3125 C 6.140625 -0.3125 6.015625 -0.3125 5.890625 -0.3125 L 5.890625 -0.015625 L 8.75 -0.015625 L 8.75 -0.3125 C 8.640625 -0.3125 8.5 -0.3125 8.390625 -0.3125 C 8.03125 -0.3125 7.71875 -0.359375 7.71875 -0.75 L 7.71875 -6.078125 C 7.71875 -6.453125 8.046875 -6.515625 8.390625 -6.515625 C 8.515625 -6.515625 8.640625 -6.515625 8.75 -6.515625 L 8.75 -6.8125 L 7.015625 -6.8125 L 6.828125 -6.78125 L 6.734375 -6.625 L 4.5625 -1.015625 L 2.390625 -6.625 L 2.296875 -6.78125 L 2.109375 -6.8125 Z M 0.375 -6.8125 "
           id="path355" />
      </g>
      <g
         id="glyph-10-12">
        <path
           d="M 0.171875 -4.296875 L 0.171875 -3.984375 L 0.375 -3.984375 C 0.890625 -3.984375 1.03125 -3.78125 1.25 -3.484375 L 2.1875 -2.265625 C 2.234375 -2.21875 2.3125 -2.140625 2.3125 -2.078125 C 2.296875 -2.03125 2.21875 -1.953125 2.1875 -1.90625 C 1.59375 -1.21875 1.15625 -0.3125 0.125 -0.3125 L 0.125 -0.015625 L 1.90625 -0.015625 L 1.90625 -0.3125 C 1.71875 -0.3125 1.609375 -0.5 1.609375 -0.640625 C 1.609375 -0.84375 1.765625 -0.984375 1.890625 -1.125 C 2 -1.28125 2.125 -1.4375 2.25 -1.578125 C 2.328125 -1.6875 2.421875 -1.78125 2.484375 -1.890625 C 2.734375 -1.609375 2.9375 -1.296875 3.15625 -1 L 3.34375 -0.75 C 3.390625 -0.703125 3.453125 -0.640625 3.453125 -0.5625 C 3.453125 -0.40625 3.234375 -0.3125 3.09375 -0.3125 L 3.09375 -0.015625 L 5.140625 -0.015625 L 5.140625 -0.3125 L 4.96875 -0.3125 C 4.796875 -0.3125 4.609375 -0.328125 4.453125 -0.40625 C 4.28125 -0.5 4.15625 -0.6875 4.03125 -0.84375 C 3.703125 -1.28125 3.359375 -1.71875 3.03125 -2.15625 L 2.9375 -2.265625 C 2.921875 -2.296875 2.90625 -2.328125 2.890625 -2.359375 C 2.890625 -2.40625 2.953125 -2.46875 2.984375 -2.515625 L 3.296875 -2.890625 C 3.484375 -3.109375 3.640625 -3.34375 3.84375 -3.546875 C 4.15625 -3.828125 4.546875 -3.984375 4.96875 -3.984375 L 4.96875 -4.296875 L 3.1875 -4.296875 L 3.1875 -3.984375 C 3.390625 -3.9375 3.46875 -3.84375 3.46875 -3.671875 C 3.46875 -3.390625 3.15625 -3.125 2.984375 -2.90625 C 2.90625 -2.8125 2.765625 -2.609375 2.71875 -2.609375 C 2.65625 -2.609375 2.515625 -2.828125 2.421875 -2.9375 C 2.203125 -3.21875 1.859375 -3.578125 1.859375 -3.75 C 1.859375 -3.890625 2.078125 -3.984375 2.203125 -3.984375 L 2.203125 -4.296875 Z M 0.171875 -4.296875 "
           id="path358" />
      </g>
      <g
         id="glyph-10-13">
        <path
           d="M 0.171875 -4.296875 L 0.171875 -3.984375 L 0.328125 -3.984375 C 0.84375 -3.984375 0.875 -3.765625 1.109375 -3.0625 C 1.359375 -2.375 1.625 -1.6875 1.859375 -1 L 2.15625 -0.15625 C 2.203125 -0.046875 2.234375 0.09375 2.375 0.09375 L 2.390625 0.09375 C 2.609375 0.09375 2.75 -0.5625 2.875 -0.890625 C 3.0625 -1.421875 3.25 -1.953125 3.453125 -2.484375 C 3.5 -2.625 3.5625 -2.765625 3.59375 -2.90625 C 3.625 -2.765625 3.6875 -2.625 3.734375 -2.484375 L 4.03125 -1.671875 C 4.203125 -1.15625 4.40625 -0.640625 4.578125 -0.125 C 4.625 -0.015625 4.671875 0.09375 4.8125 0.09375 C 5.03125 0.09375 5.1875 -0.609375 5.3125 -0.96875 L 5.875 -2.546875 C 6.109375 -3.1875 6.25 -3.984375 7.015625 -3.984375 L 7.015625 -4.296875 L 5.359375 -4.296875 L 5.359375 -3.984375 C 5.625 -3.984375 5.90625 -3.84375 5.9375 -3.5625 C 5.9375 -3.28125 5.765625 -2.953125 5.671875 -2.703125 C 5.515625 -2.265625 5.359375 -1.84375 5.21875 -1.421875 C 5.140625 -1.203125 5.03125 -0.984375 4.984375 -0.765625 L 4.96875 -0.765625 C 4.921875 -1 4.796875 -1.3125 4.6875 -1.5625 C 4.46875 -2.203125 4.234375 -2.84375 4 -3.5 C 3.984375 -3.5625 3.953125 -3.65625 3.953125 -3.734375 L 3.953125 -3.765625 C 4 -3.984375 4.328125 -3.984375 4.53125 -3.984375 L 4.53125 -4.296875 L 2.59375 -4.296875 L 2.59375 -3.984375 L 2.765625 -3.984375 C 3.15625 -3.984375 3.25 -3.84375 3.375 -3.5 C 3.40625 -3.421875 3.453125 -3.34375 3.453125 -3.265625 C 3.4375 -3.171875 3.390625 -3.078125 3.359375 -2.984375 L 2.796875 -1.40625 C 2.734375 -1.234375 2.6875 -1.0625 2.609375 -0.90625 C 2.5 -1.171875 2.40625 -1.453125 2.3125 -1.71875 C 2.15625 -2.15625 2 -2.578125 1.859375 -3.015625 L 1.671875 -3.515625 C 1.65625 -3.578125 1.609375 -3.65625 1.609375 -3.71875 C 1.609375 -3.984375 1.984375 -3.984375 2.203125 -3.984375 L 2.203125 -4.296875 Z M 0.171875 -4.296875 "
           id="path361" />
      </g>
      <g
         id="glyph-10-14">
        <path
           d="M 0.328125 -6.8125 L 0.328125 -6.515625 L 0.484375 -6.515625 C 0.84375 -6.515625 1.109375 -6.46875 1.109375 -5.984375 L 1.109375 -0.953125 C 1.109375 -0.890625 1.109375 -0.8125 1.109375 -0.734375 C 1.109375 -0.359375 0.84375 -0.3125 0.5625 -0.3125 L 0.328125 -0.3125 L 0.328125 -0.015625 L 2.546875 -0.015625 L 2.546875 -0.3125 L 2.296875 -0.3125 C 2.015625 -0.3125 1.78125 -0.359375 1.78125 -0.75 L 1.78125 -6.921875 Z M 0.328125 -6.8125 "
           id="path364" />
      </g>
      <g
         id="glyph-10-15">
        <path
           d="M 0.3125 -4.296875 L 0.3125 -3.984375 L 0.46875 -3.984375 C 0.796875 -3.984375 1.09375 -3.953125 1.09375 -3.484375 L 1.09375 -0.734375 C 1.09375 -0.328125 0.8125 -0.3125 0.375 -0.3125 L 0.3125 -0.3125 L 0.3125 -0.015625 L 2.578125 -0.015625 L 2.578125 -0.3125 L 2.3125 -0.3125 C 2.03125 -0.3125 1.796875 -0.359375 1.796875 -0.734375 L 1.796875 -2.546875 C 1.796875 -3.265625 2.15625 -4.1875 3.15625 -4.1875 C 3.78125 -4.1875 3.84375 -3.5 3.84375 -3.078125 L 3.84375 -0.6875 C 3.84375 -0.34375 3.5625 -0.3125 3.25 -0.3125 L 3.078125 -0.3125 L 3.078125 -0.015625 L 5.328125 -0.015625 L 5.328125 -0.3125 L 5.078125 -0.3125 C 4.8125 -0.3125 4.546875 -0.359375 4.546875 -0.703125 L 4.546875 -2.875 C 4.546875 -3.203125 4.53125 -3.546875 4.375 -3.84375 C 4.140625 -4.28125 3.640625 -4.40625 3.1875 -4.40625 C 2.578125 -4.40625 1.9375 -3.984375 1.75 -3.390625 L 1.734375 -4.40625 Z M 0.3125 -4.296875 "
           id="path367" />
      </g>
      <g
         id="glyph-10-16">
        <path
           d="M 3.03125 -6.8125 L 3.03125 -6.515625 L 3.1875 -6.515625 C 3.53125 -6.515625 3.8125 -6.46875 3.8125 -5.890625 L 3.796875 -3.796875 C 3.5625 -4.203125 2.984375 -4.40625 2.53125 -4.40625 C 1.3125 -4.40625 0.328125 -3.34375 0.328125 -2.140625 C 0.328125 -1.078125 1.140625 0.09375 2.46875 0.09375 C 2.984375 0.09375 3.453125 -0.15625 3.78125 -0.546875 L 3.78125 0.09375 L 5.25 -0.015625 L 5.25 -0.3125 L 5.078125 -0.3125 C 4.78125 -0.3125 4.46875 -0.34375 4.46875 -0.8125 L 4.46875 -6.921875 Z M 1.171875 -1.90625 L 1.171875 -2.046875 C 1.171875 -2.796875 1.25 -3.53125 1.9375 -4 C 2.140625 -4.109375 2.375 -4.1875 2.609375 -4.1875 C 3.09375 -4.1875 3.78125 -3.78125 3.78125 -3.15625 C 3.78125 -3.03125 3.78125 -2.90625 3.78125 -2.765625 L 3.78125 -1.109375 C 3.78125 -0.984375 3.734375 -0.890625 3.65625 -0.796875 C 3.40625 -0.40625 2.96875 -0.125 2.5 -0.125 C 1.78125 -0.125 1.3125 -0.78125 1.203125 -1.46875 C 1.1875 -1.609375 1.1875 -1.765625 1.171875 -1.90625 Z M 1.171875 -1.90625 "
           id="path370" />
      </g>
      <g
         id="glyph-10-17">
        <path
           d="M 0.328125 -6.8125 L 0.328125 -6.515625 C 0.453125 -6.515625 0.59375 -6.515625 0.703125 -6.515625 C 1.0625 -6.515625 1.359375 -6.46875 1.359375 -6.078125 L 1.359375 -0.75 C 1.359375 -0.375 1.03125 -0.3125 0.6875 -0.3125 C 0.5625 -0.3125 0.4375 -0.3125 0.328125 -0.3125 L 0.328125 -0.015625 L 3.265625 -0.015625 L 3.265625 -0.3125 C 3.140625 -0.3125 2.984375 -0.3125 2.859375 -0.3125 C 2.53125 -0.3125 2.25 -0.375 2.25 -0.75 L 2.25 -2.421875 C 2.25 -2.578125 2.4375 -2.71875 2.546875 -2.828125 C 2.71875 -2.96875 2.875 -3.125 3.03125 -3.28125 C 3.15625 -3.390625 3.296875 -3.5 3.390625 -3.625 L 3.40625 -3.625 C 3.546875 -3.375 3.734375 -3.140625 3.890625 -2.90625 C 4.3125 -2.265625 4.765625 -1.640625 5.1875 -0.984375 C 5.25 -0.875 5.34375 -0.75 5.359375 -0.625 C 5.359375 -0.390625 5.078125 -0.3125 4.890625 -0.3125 L 4.78125 -0.3125 L 4.78125 -0.015625 L 7.34375 -0.015625 L 7.34375 -0.3125 C 7.125 -0.3125 6.875 -0.3125 6.671875 -0.421875 C 6.5 -0.515625 6.375 -0.6875 6.25 -0.84375 L 5.828125 -1.46875 C 5.25 -2.359375 4.671875 -3.21875 4.0625 -4.09375 C 4.046875 -4.109375 4.015625 -4.140625 4.015625 -4.171875 L 4.015625 -4.1875 C 4.015625 -4.265625 4.515625 -4.703125 4.75 -4.921875 L 5.4375 -5.578125 C 5.953125 -6.0625 6.453125 -6.515625 7.171875 -6.515625 L 7.203125 -6.515625 L 7.203125 -6.8125 L 5.078125 -6.8125 L 5.078125 -6.515625 C 5.265625 -6.515625 5.53125 -6.4375 5.53125 -6.171875 C 5.53125 -5.984375 5.359375 -5.828125 5.21875 -5.71875 L 5.109375 -5.609375 C 5.0625 -5.578125 5.03125 -5.515625 4.96875 -5.484375 C 4.0625 -4.609375 3.15625 -3.75 2.25 -2.875 L 2.25 -6.046875 C 2.25 -6.5 2.59375 -6.515625 3.1875 -6.515625 L 3.265625 -6.515625 L 3.265625 -6.8125 Z M 0.328125 -6.8125 "
           id="path373" />
      </g>
      <g
         id="glyph-10-18">
        <path
           d="M 0 -2.765625 L 0 -2.546875 L 4.96875 -2.546875 L 4.96875 -2.765625 Z M 0 -2.765625 "
           id="path376" />
      </g>
      <g
         id="glyph-10-19">
        <path
           d="M 0.1875 -6.8125 L 0.1875 -6.515625 L 0.421875 -6.515625 C 0.640625 -6.515625 0.890625 -6.5 1.03125 -6.375 C 1.140625 -6.25 1.1875 -6.0625 1.25 -5.90625 C 1.828125 -4.46875 2.359375 -2.984375 2.90625 -1.546875 L 3.5 0.03125 C 3.546875 0.15625 3.59375 0.203125 3.734375 0.203125 C 3.875 0.203125 3.921875 0.15625 3.96875 0.03125 L 4.046875 -0.1875 C 4.75 -2.03125 5.453125 -3.875 6.140625 -5.6875 C 6.296875 -6.109375 6.5 -6.515625 7.28125 -6.515625 L 7.28125 -6.8125 L 5.171875 -6.8125 L 5.171875 -6.515625 C 5.46875 -6.515625 5.90625 -6.375 5.90625 -6.015625 L 5.90625 -5.984375 C 5.890625 -5.90625 5.859375 -5.828125 5.828125 -5.765625 L 5.703125 -5.421875 C 5.546875 -5.046875 5.40625 -4.65625 5.265625 -4.28125 L 4.421875 -2.0625 C 4.296875 -1.71875 4.171875 -1.359375 4.03125 -1.015625 C 3.875 -1.390625 3.734375 -1.78125 3.59375 -2.15625 C 3.09375 -3.453125 2.59375 -4.765625 2.109375 -6.078125 C 2.078125 -6.125 2.078125 -6.171875 2.078125 -6.21875 L 2.078125 -6.25 C 2.125 -6.515625 2.59375 -6.515625 2.875 -6.515625 L 2.875 -6.8125 Z M 0.1875 -6.8125 "
           id="path379" />
      </g>
      <g
         id="glyph-10-20">
        <path
           d="M 1.1875 -0.234375 L 1.1875 -0.21875 C 0.71875 -0.125 0.28125 0.3125 0.28125 0.78125 C 0.28125 1.71875 1.71875 2.046875 2.484375 2.046875 C 3.3125 2.046875 4.6875 1.75 4.6875 0.71875 C 4.6875 0.0625 4.234375 -0.375 3.640625 -0.546875 C 3.28125 -0.65625 2.90625 -0.671875 2.53125 -0.671875 L 1.625 -0.671875 C 1.3125 -0.703125 1.0625 -1.015625 1.0625 -1.328125 L 1.0625 -1.390625 C 1.0625 -1.515625 1.140625 -1.78125 1.234375 -1.78125 C 1.359375 -1.75 1.5 -1.640625 1.65625 -1.578125 C 1.828125 -1.53125 2.03125 -1.5 2.21875 -1.5 C 3.046875 -1.5 3.84375 -2.109375 3.84375 -2.953125 C 3.84375 -3.296875 3.703125 -3.6875 3.421875 -3.90625 L 3.421875 -3.921875 C 3.703125 -4.109375 3.953125 -4.296875 4.3125 -4.296875 C 4.34375 -4.296875 4.375 -4.296875 4.40625 -4.28125 C 4.3125 -4.234375 4.25 -4.15625 4.25 -4.03125 C 4.25 -3.875 4.390625 -3.734375 4.546875 -3.734375 C 4.71875 -3.734375 4.828125 -3.875 4.828125 -4.03125 C 4.828125 -4.296875 4.609375 -4.515625 4.34375 -4.515625 C 3.984375 -4.515625 3.65625 -4.375 3.390625 -4.15625 C 3.359375 -4.125 3.3125 -4.09375 3.28125 -4.078125 L 3.265625 -4.078125 C 3.203125 -4.078125 3.125 -4.15625 3.078125 -4.1875 C 2.828125 -4.328125 2.515625 -4.40625 2.21875 -4.40625 C 1.4375 -4.40625 0.59375 -3.859375 0.59375 -2.953125 C 0.59375 -2.625 0.71875 -2.328125 0.921875 -2.0625 C 0.953125 -2.03125 1.03125 -1.96875 1.03125 -1.921875 C 1.03125 -1.875 0.96875 -1.828125 0.953125 -1.78125 C 0.8125 -1.578125 0.75 -1.328125 0.75 -1.09375 C 0.75 -0.78125 0.890625 -0.375 1.1875 -0.234375 Z M 0.8125 0.84375 L 0.8125 0.75 C 0.8125 0.234375 1.265625 -0.078125 1.796875 -0.078125 L 2.578125 -0.078125 C 3.203125 -0.078125 4.171875 0.015625 4.171875 0.78125 C 4.171875 1.5 3.09375 1.8125 2.484375 1.8125 C 1.828125 1.8125 0.90625 1.515625 0.8125 0.84375 Z M 1.34375 -2.75 L 1.34375 -2.875 C 1.34375 -3.421875 1.46875 -4.171875 2.21875 -4.171875 C 2.828125 -4.171875 3.078125 -3.59375 3.078125 -2.953125 C 3.078125 -2.546875 3 -1.734375 2.21875 -1.734375 C 1.96875 -1.734375 1.71875 -1.859375 1.546875 -2.078125 C 1.390625 -2.265625 1.375 -2.515625 1.34375 -2.75 Z M 1.34375 -2.75 "
           id="path382" />
      </g>
      <g
         id="glyph-10-21">
        <path
           d="M 0.3125 -4.296875 L 0.3125 -3.984375 L 0.46875 -3.984375 C 0.796875 -3.984375 1.09375 -3.953125 1.09375 -3.484375 L 1.09375 -0.734375 C 1.09375 -0.328125 0.8125 -0.3125 0.375 -0.3125 L 0.3125 -0.3125 L 0.3125 -0.015625 L 2.578125 -0.015625 L 2.578125 -0.3125 L 2.3125 -0.3125 C 2.03125 -0.3125 1.796875 -0.359375 1.796875 -0.734375 L 1.796875 -2.546875 C 1.796875 -3.28125 2.1875 -4.1875 3.15625 -4.1875 C 3.78125 -4.1875 3.859375 -3.53125 3.859375 -3.078125 L 3.859375 -0.703125 C 3.859375 -0.34375 3.5625 -0.3125 3.234375 -0.3125 L 3.078125 -0.3125 L 3.078125 -0.015625 L 5.328125 -0.015625 L 5.328125 -0.3125 L 5.078125 -0.3125 C 4.796875 -0.3125 4.5625 -0.359375 4.5625 -0.734375 L 4.5625 -2.546875 C 4.5625 -3.28125 4.953125 -4.1875 5.90625 -4.1875 C 6.546875 -4.1875 6.625 -3.53125 6.625 -3.078125 L 6.625 -0.703125 C 6.625 -0.34375 6.3125 -0.3125 5.984375 -0.3125 L 5.84375 -0.3125 L 5.84375 -0.015625 L 8.09375 -0.015625 L 8.09375 -0.3125 L 7.890625 -0.3125 C 7.59375 -0.3125 7.3125 -0.34375 7.3125 -0.703125 L 7.3125 -2.953125 C 7.3125 -3.3125 7.296875 -3.65625 7.0625 -3.984375 C 6.796875 -4.3125 6.375 -4.40625 5.96875 -4.40625 C 5.328125 -4.40625 4.796875 -4.03125 4.53125 -3.453125 C 4.34375 -4.15625 3.890625 -4.40625 3.203125 -4.40625 C 2.5625 -4.40625 1.953125 -4 1.75 -3.390625 L 1.734375 -4.40625 Z M 0.3125 -4.296875 "
           id="path385" />
      </g>
      <g
         id="glyph-10-22">
        <path
           d="M 0.265625 -4.296875 L 0.265625 -3.984375 L 0.453125 -3.984375 C 0.75 -3.984375 1.046875 -3.953125 1.046875 -3.5625 L 1.046875 1.21875 C 1.046875 1.578125 0.78125 1.609375 0.5 1.609375 L 0.265625 1.609375 L 0.265625 1.921875 L 2.515625 1.921875 L 2.515625 1.609375 L 2.28125 1.609375 C 1.984375 1.609375 1.75 1.578125 1.75 1.21875 L 1.75 -0.515625 C 1.984375 -0.09375 2.546875 0.09375 2.96875 0.09375 C 4.203125 0.09375 5.1875 -0.953125 5.1875 -2.15625 C 5.1875 -3.359375 4.265625 -4.40625 3.09375 -4.40625 C 2.546875 -4.40625 2.078125 -4.171875 1.71875 -3.765625 L 1.71875 -4.40625 Z M 4.34375 -1.984375 C 4.296875 -1.25 3.90625 -0.203125 3 -0.125 L 2.9375 -0.125 C 2.515625 -0.125 2.125 -0.359375 1.890625 -0.71875 C 1.796875 -0.828125 1.75 -0.921875 1.75 -1.0625 L 1.75 -2.734375 C 1.75 -2.875 1.734375 -3 1.734375 -3.125 C 1.734375 -3.65625 2.40625 -4.15625 3 -4.15625 C 4 -4.15625 4.359375 -2.84375 4.359375 -2.140625 C 4.359375 -2.09375 4.359375 -2.03125 4.34375 -1.984375 Z M 4.34375 -1.984375 "
           id="path388" />
      </g>
      <g
         id="glyph-10-23">
        <path
           d="M 1.75 -4.46875 C 1.390625 -4.421875 1 -4.359375 0.703125 -4.109375 C 0.46875 -3.890625 0.328125 -3.5625 0.328125 -3.234375 C 0.328125 -1.53125 3.09375 -2.5 3.09375 -1 C 3.09375 -0.40625 2.546875 -0.125 2 -0.125 C 1.25 -0.125 0.734375 -0.65625 0.59375 -1.515625 C 0.578125 -1.609375 0.5625 -1.6875 0.453125 -1.6875 C 0.375 -1.6875 0.328125 -1.640625 0.328125 -1.5625 L 0.328125 0.015625 C 0.34375 0.0625 0.375 0.09375 0.421875 0.09375 L 0.4375 0.09375 C 0.59375 0.09375 0.75 -0.265625 0.875 -0.296875 L 0.890625 -0.296875 C 0.96875 -0.296875 1.234375 -0.046875 1.453125 0.015625 C 1.609375 0.078125 1.796875 0.09375 1.96875 0.09375 C 2.796875 0.09375 3.59375 -0.34375 3.59375 -1.25 C 3.59375 -1.90625 3.109375 -2.453125 2.453125 -2.625 C 1.828125 -2.796875 0.8125 -2.796875 0.8125 -3.515625 C 0.8125 -4.125 1.484375 -4.28125 1.921875 -4.28125 C 2.40625 -4.28125 3.09375 -4 3.09375 -3.15625 C 3.09375 -3.0625 3.09375 -2.984375 3.203125 -2.984375 C 3.3125 -2.984375 3.34375 -3.0625 3.34375 -3.15625 C 3.34375 -3.203125 3.34375 -3.265625 3.34375 -3.296875 L 3.34375 -4.328125 C 3.34375 -4.390625 3.3125 -4.46875 3.234375 -4.46875 C 3.078125 -4.46875 2.96875 -4.21875 2.859375 -4.21875 L 2.84375 -4.21875 C 2.765625 -4.21875 2.609375 -4.34375 2.5 -4.390625 C 2.3125 -4.453125 2.109375 -4.46875 1.921875 -4.46875 C 1.859375 -4.46875 1.8125 -4.46875 1.75 -4.46875 Z M 1.75 -4.46875 "
           id="path391" />
      </g>
      <g
         id="glyph-10-24">
        <path
           d="M 3.578125 -3.859375 C 3.3125 -3.84375 3.109375 -3.671875 3.109375 -3.40625 C 3.109375 -3.125 3.296875 -2.9375 3.5625 -2.9375 C 3.875 -2.9375 4.03125 -3.15625 4.03125 -3.4375 L 4.03125 -3.5 C 3.921875 -4.234375 3.078125 -4.46875 2.5 -4.46875 C 1.28125 -4.46875 0.328125 -3.40625 0.328125 -2.15625 C 0.328125 -1.03125 1.203125 0.09375 2.5 0.09375 C 3.15625 0.09375 3.796875 -0.265625 4.0625 -0.953125 C 4.09375 -1.015625 4.140625 -1.109375 4.140625 -1.171875 C 4.140625 -1.25 4.09375 -1.296875 4.015625 -1.296875 C 3.875 -1.296875 3.78125 -0.921875 3.703125 -0.78125 C 3.46875 -0.40625 3.0625 -0.15625 2.609375 -0.15625 C 1.546875 -0.15625 1.21875 -1.21875 1.171875 -2 L 1.171875 -2.125 C 1.171875 -2.921875 1.359375 -4.109375 2.453125 -4.21875 L 2.53125 -4.21875 C 2.90625 -4.21875 3.296875 -4.109375 3.578125 -3.859375 Z M 3.578125 -3.859375 "
           id="path394" />
      </g>
      <g
         id="glyph-10-25">
        <path
           d="M 0.265625 -6.8125 L 0.265625 -6.515625 L 0.4375 -6.515625 C 0.75 -6.515625 1.046875 -6.484375 1.046875 -6.015625 L 1.046875 -0.015625 L 1.28125 -0.03125 L 1.421875 -0.203125 L 1.65625 -0.625 L 1.671875 -0.625 C 1.90625 -0.140625 2.5 0.09375 3 0.09375 C 4.234375 0.09375 5.1875 -0.984375 5.1875 -2.15625 C 5.1875 -3.3125 4.3125 -4.40625 3.046875 -4.40625 C 2.515625 -4.40625 2.0625 -4.15625 1.71875 -3.765625 L 1.71875 -6.921875 Z M 4.34375 -1.90625 C 4.3125 -1.4375 4.25 -1.015625 3.953125 -0.640625 C 3.703125 -0.328125 3.328125 -0.125 2.9375 -0.125 C 2.5 -0.125 2.109375 -0.375 1.890625 -0.734375 C 1.796875 -0.84375 1.75 -0.921875 1.75 -1.078125 L 1.75 -2.734375 C 1.75 -2.875 1.734375 -3 1.734375 -3.125 C 1.734375 -3.734375 2.46875 -4.1875 3.015625 -4.1875 C 4.09375 -4.1875 4.359375 -2.9375 4.359375 -2.140625 C 4.359375 -2.0625 4.359375 -2 4.34375 -1.90625 Z M 4.34375 -1.90625 "
           id="path397" />
      </g>
      <g
         id="glyph-10-26">
        <path
           d="M 0.109375 -2.4375 L 0.109375 -1.859375 L 2.765625 -1.859375 L 2.765625 -2.4375 Z M 0.109375 -2.4375 "
           id="path400" />
      </g>
      <g
         id="glyph-10-27">
        <path
           d="M 1.3125 -1.0625 C 1.0625 -1.03125 0.859375 -0.796875 0.859375 -0.546875 C 0.859375 -0.296875 1.0625 -0.015625 1.359375 -0.015625 C 1.640625 -0.015625 1.90625 -0.21875 1.90625 -0.53125 C 1.90625 -0.78125 1.71875 -1.0625 1.390625 -1.0625 C 1.359375 -1.0625 1.328125 -1.0625 1.3125 -1.0625 Z M 1.3125 -1.0625 "
           id="path403" />
      </g>
    </g>
    <clipPath
       id="clip-0">
      <path
         clip-rule="nonzero"
         d="M 255.113281 97 L 333 97 L 333 110.648438 L 255.113281 110.648438 Z M 255.113281 97 "
         id="path408" />
    </clipPath>
    <clipPath
       id="clip-1">
      <path
         clip-rule="nonzero"
         d="M 319 97 L 343 97 L 343 110.648438 L 319 110.648438 Z M 319 97 "
         id="path411" />
    </clipPath>
    <clipPath
       id="clip-2">
      <path
         clip-rule="nonzero"
         d="M 270 273 L 364.617188 273 L 364.617188 275 L 270 275 Z M 270 273 "
         id="path414" />
    </clipPath>
    <clipPath
       id="clip-3">
      <path
         clip-rule="evenodd"
         d="M 263.617188 292.070312 L 364.617188 292.070312 L 364.617188 186.070312 L 263.617188 186.070312 Z M 355.242188 275.707031 L 364.753906 275.707031 L 364.753906 271.925781 L 355.242188 271.925781 L 362.800781 273.816406 Z M 355.242188 275.707031 "
         id="path417" />
    </clipPath>
    <clipPath
       id="clip-4">
      <path
         clip-rule="nonzero"
         d="M 348 265 L 364.617188 265 L 364.617188 283 L 348 283 Z M 348 265 "
         id="path420" />
    </clipPath>
    <clipPath
       id="clip-5">
      <path
         clip-rule="nonzero"
         d="M 278 188 L 280 188 L 280 275 L 278 275 Z M 278 188 "
         id="path423" />
    </clipPath>
    <clipPath
       id="clip-6">
      <path
         clip-rule="evenodd"
         d="M 263.617188 292.070312 L 364.617188 292.070312 L 364.617188 186.070312 L 263.617188 186.070312 Z M 280.660156 197.347656 L 280.660156 187.835938 L 276.882812 187.835938 L 276.882812 197.347656 L 278.773438 189.789062 Z M 280.660156 197.347656 "
         id="path426" />
    </clipPath>
    <clipPath
       id="clip-7">
      <path
         clip-rule="nonzero"
         d="M 270 186.070312 L 288 186.070312 L 288 205 L 270 205 Z M 270 186.070312 "
         id="path429" />
    </clipPath>
    <clipPath
       id="clip-8">
      <path
         clip-rule="nonzero"
         d="M 278 372 L 279 372 L 279 459 L 278 459 Z M 278 372 "
         id="path432" />
    </clipPath>
    <clipPath
       id="clip-9">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 280.574219 381.59375 L 280.574219 372.082031 L 276.796875 372.082031 L 276.796875 381.59375 L 278.683594 374.035156 Z M 280.574219 381.59375 "
         id="path435" />
    </clipPath>
    <clipPath
       id="clip-10">
      <path
         clip-rule="nonzero"
         d="M 270 370.316406 L 288 370.316406 L 288 389 L 270 389 Z M 270 370.316406 "
         id="path438" />
    </clipPath>
    <clipPath
       id="clip-11">
      <path
         clip-rule="nonzero"
         d="M 269 457 L 364 457 L 364 459 L 269 459 Z M 269 457 "
         id="path441" />
    </clipPath>
    <clipPath
       id="clip-12">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path444" />
    </clipPath>
    <clipPath
       id="clip-13">
      <path
         clip-rule="nonzero"
         d="M 355 456 L 363 456 L 363 460 L 355 460 Z M 355 456 "
         id="path447" />
    </clipPath>
    <clipPath
       id="clip-14">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path450" />
    </clipPath>
    <clipPath
       id="clip-15">
      <path
         clip-rule="nonzero"
         d="M 348 449 L 366 449 L 366 467 L 348 467 Z M 348 449 "
         id="path453" />
    </clipPath>
    <clipPath
       id="clip-16">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path456" />
    </clipPath>
    <clipPath
       id="clip-17">
      <path
         clip-rule="nonzero"
         d="M 275 401 L 282 401 L 282 402 L 275 402 Z M 275 401 "
         id="path459" />
    </clipPath>
    <clipPath
       id="clip-18">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path462" />
    </clipPath>
    <clipPath
       id="clip-19">
      <path
         clip-rule="nonzero"
         d="M 277 400 L 280 400 L 280 460 L 277 460 Z M 277 400 "
         id="path465" />
    </clipPath>
    <clipPath
       id="clip-20">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path468" />
    </clipPath>
    <clipPath
       id="clip-21">
      <path
         clip-rule="nonzero"
         d="M 277 400 L 353 400 L 353 459 L 277 459 Z M 277 400 "
         id="path471" />
    </clipPath>
    <clipPath
       id="clip-22">
      <path
         clip-rule="evenodd"
         d="M 255.113281 476.316406 L 365.113281 476.316406 L 365.113281 370.316406 L 255.113281 370.316406 Z M 355.15625 459.953125 L 364.667969 459.953125 L 364.667969 456.175781 L 355.15625 456.175781 L 362.714844 458.066406 Z M 355.15625 459.953125 "
         id="path474" />
    </clipPath>
    <clipPath
       id="clip-23">
      <path
         clip-rule="nonzero"
         d="M 99 188 L 101 188 L 101 275 L 99 275 Z M 99 188 "
         id="path477" />
    </clipPath>
    <clipPath
       id="clip-24">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 102.003906 197.347656 L 102.003906 187.835938 L 98.222656 187.835938 L 98.222656 197.347656 L 100.113281 189.789062 Z M 102.003906 197.347656 "
         id="path480" />
    </clipPath>
    <clipPath
       id="clip-25">
      <path
         clip-rule="nonzero"
         d="M 91 186.070312 L 109 186.070312 L 109 205 L 91 205 Z M 91 186.070312 "
         id="path483" />
    </clipPath>
    <clipPath
       id="clip-26">
      <path
         clip-rule="nonzero"
         d="M 91 273 L 186 273 L 186 275 L 91 275 Z M 91 273 "
         id="path486" />
    </clipPath>
    <clipPath
       id="clip-27">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 176.582031 275.707031 L 186.09375 275.707031 L 186.09375 271.925781 L 176.582031 271.925781 L 184.140625 273.816406 Z M 176.582031 275.707031 "
         id="path489" />
    </clipPath>
    <clipPath
       id="clip-28">
      <path
         clip-rule="nonzero"
         d="M 176 271 L 185 271 L 185 276 L 176 276 Z M 176 271 "
         id="path492" />
    </clipPath>
    <clipPath
       id="clip-29">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 176.582031 275.707031 L 186.09375 275.707031 L 186.09375 271.925781 L 176.582031 271.925781 L 184.140625 273.816406 Z M 176.582031 275.707031 "
         id="path495" />
    </clipPath>
    <clipPath
       id="clip-30">
      <path
         clip-rule="nonzero"
         d="M 169 265 L 187 265 L 187 283 L 169 283 Z M 169 265 "
         id="path498" />
    </clipPath>
    <clipPath
       id="clip-31">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 176.582031 275.707031 L 186.09375 275.707031 L 186.09375 271.925781 L 176.582031 271.925781 L 184.140625 273.816406 Z M 176.582031 275.707031 "
         id="path501" />
    </clipPath>
    <clipPath
       id="clip-32">
      <path
         clip-rule="nonzero"
         d="M 99 216 L 178 216 L 178 275 L 99 275 Z M 99 216 "
         id="path504" />
    </clipPath>
    <clipPath
       id="clip-33">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 176.582031 275.707031 L 186.09375 275.707031 L 186.09375 271.925781 L 176.582031 271.925781 L 184.140625 273.816406 Z M 176.582031 275.707031 "
         id="path507" />
    </clipPath>
    <clipPath
       id="clip-34">
      <path
         clip-rule="nonzero"
         d="M 97 216 L 104 216 L 104 218 L 97 218 Z M 97 216 "
         id="path510" />
    </clipPath>
    <clipPath
       id="clip-35">
      <path
         clip-rule="evenodd"
         d="M 85.039062 292.070312 L 186.039062 292.070312 L 186.039062 186.070312 L 85.039062 186.070312 Z M 176.582031 275.707031 L 186.09375 275.707031 L 186.09375 271.925781 L 176.582031 271.925781 L 184.140625 273.816406 Z M 176.582031 275.707031 "
         id="path513" />
    </clipPath>
    <clipPath
       id="clip-36">
      <path
         clip-rule="nonzero"
         d="M 91 457 L 186 457 L 186 459 L 91 459 Z M 91 457 "
         id="path516" />
    </clipPath>
    <clipPath
       id="clip-37">
      <path
         clip-rule="evenodd"
         d="M 85.039062 476.316406 L 186.039062 476.316406 L 186.039062 370.316406 L 85.039062 370.316406 Z M 176.664062 459.953125 L 186.175781 459.953125 L 186.175781 456.175781 L 176.664062 456.175781 L 184.222656 458.066406 Z M 176.664062 459.953125 "
         id="path519" />
    </clipPath>
    <clipPath
       id="clip-38">
      <path
         clip-rule="nonzero"
         d="M 169 449 L 186.039062 449 L 186.039062 467 L 169 467 Z M 169 449 "
         id="path522" />
    </clipPath>
    <clipPath
       id="clip-39">
      <path
         clip-rule="nonzero"
         d="M 99 372 L 101 372 L 101 459 L 99 459 Z M 99 372 "
         id="path525" />
    </clipPath>
    <clipPath
       id="clip-40">
      <path
         clip-rule="evenodd"
         d="M 85.039062 476.316406 L 186.039062 476.316406 L 186.039062 370.316406 L 85.039062 370.316406 Z M 102.085938 381.59375 L 102.085938 372.082031 L 98.304688 372.082031 L 98.304688 381.59375 L 100.195312 374.035156 Z M 102.085938 381.59375 "
         id="path528" />
    </clipPath>
    <clipPath
       id="clip-41">
      <path
         clip-rule="nonzero"
         d="M 91 370.316406 L 109 370.316406 L 109 389 L 91 389 Z M 91 370.316406 "
         id="path531" />
    </clipPath>
    <clipPath
       id="clip-42">
      <path
         clip-rule="nonzero"
         d="M 443 116 L 467 116 L 467 130.492188 L 443 130.492188 Z M 443 116 "
         id="path534" />
    </clipPath>
    <clipPath
       id="clip-43">
      <path
         clip-rule="nonzero"
         d="M 411.019531 106 L 425 106 L 425 108 L 411.019531 108 Z M 411.019531 106 "
         id="path537" />
    </clipPath>
    <clipPath
       id="clip-44">
      <path
         clip-rule="nonzero"
         d="M 431 273 L 526 273 L 526 275 L 431 275 Z M 431 273 "
         id="path540" />
    </clipPath>
    <clipPath
       id="clip-45">
      <path
         clip-rule="evenodd"
         d="M 419.527344 292.070312 L 526.527344 292.070312 L 526.527344 186.070312 L 419.527344 186.070312 Z M 516.75 275.707031 L 526.261719 275.707031 L 526.261719 271.925781 L 516.75 271.925781 L 524.308594 273.816406 Z M 516.75 275.707031 "
         id="path543" />
    </clipPath>
    <clipPath
       id="clip-46">
      <path
         clip-rule="nonzero"
         d="M 510 265 L 526.527344 265 L 526.527344 283 L 510 283 Z M 510 265 "
         id="path546" />
    </clipPath>
    <clipPath
       id="clip-47">
      <path
         clip-rule="nonzero"
         d="M 440 188 L 441 188 L 441 275 L 440 275 Z M 440 188 "
         id="path549" />
    </clipPath>
    <clipPath
       id="clip-48">
      <path
         clip-rule="evenodd"
         d="M 419.527344 292.070312 L 526.527344 292.070312 L 526.527344 186.070312 L 419.527344 186.070312 Z M 442.167969 197.347656 L 442.167969 187.835938 L 438.390625 187.835938 L 438.390625 197.347656 L 440.277344 189.789062 Z M 442.167969 197.347656 "
         id="path552" />
    </clipPath>
    <clipPath
       id="clip-49">
      <path
         clip-rule="nonzero"
         d="M 431 186.070312 L 449 186.070312 L 449 205 L 431 205 Z M 431 186.070312 "
         id="path555" />
    </clipPath>
    <clipPath
       id="clip-50">
      <path
         clip-rule="nonzero"
         d="M 434 372 L 435 372 L 435 459 L 434 459 Z M 434 372 "
         id="path558" />
    </clipPath>
    <clipPath
       id="clip-51">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 436.480469 381.59375 L 436.480469 372.082031 L 432.703125 372.082031 L 432.703125 381.59375 L 434.59375 374.035156 Z M 436.480469 381.59375 "
         id="path561" />
    </clipPath>
    <clipPath
       id="clip-52">
      <path
         clip-rule="nonzero"
         d="M 426 370.316406 L 444 370.316406 L 444 389 L 426 389 Z M 426 370.316406 "
         id="path564" />
    </clipPath>
    <clipPath
       id="clip-53">
      <path
         clip-rule="nonzero"
         d="M 425 457 L 520 457 L 520 459 L 425 459 Z M 425 457 "
         id="path567" />
    </clipPath>
    <clipPath
       id="clip-54">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path570" />
    </clipPath>
    <clipPath
       id="clip-55">
      <path
         clip-rule="nonzero"
         d="M 511 456 L 519 456 L 519 460 L 511 460 Z M 511 456 "
         id="path573" />
    </clipPath>
    <clipPath
       id="clip-56">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path576" />
    </clipPath>
    <clipPath
       id="clip-57">
      <path
         clip-rule="nonzero"
         d="M 504 449 L 522 449 L 522 467 L 504 467 Z M 504 449 "
         id="path579" />
    </clipPath>
    <clipPath
       id="clip-58">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path582" />
    </clipPath>
    <clipPath
       id="clip-59">
      <path
         clip-rule="nonzero"
         d="M 431 401 L 438 401 L 438 402 L 431 402 Z M 431 401 "
         id="path585" />
    </clipPath>
    <clipPath
       id="clip-60">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path588" />
    </clipPath>
    <clipPath
       id="clip-61">
      <path
         clip-rule="nonzero"
         d="M 433 400 L 513 400 L 513 403 L 433 403 Z M 433 400 "
         id="path591" />
    </clipPath>
    <clipPath
       id="clip-62">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path594" />
    </clipPath>
    <clipPath
       id="clip-63">
      <path
         clip-rule="nonzero"
         d="M 432 399 L 437 399 L 437 404 L 432 404 Z M 432 399 "
         id="path597" />
    </clipPath>
    <clipPath
       id="clip-64">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path600" />
    </clipPath>
    <clipPath
       id="clip-65">
      <path
         clip-rule="nonzero"
         d="M 431 398 L 438 398 L 438 405 L 431 405 Z M 431 398 "
         id="path603" />
    </clipPath>
    <clipPath
       id="clip-66">
      <path
         clip-rule="evenodd"
         d="M 411.019531 476.316406 L 521.019531 476.316406 L 521.019531 370.316406 L 411.019531 370.316406 Z M 511.0625 459.953125 L 520.574219 459.953125 L 520.574219 456.175781 L 511.0625 456.175781 L 518.621094 458.066406 Z M 511.0625 459.953125 "
         id="path606" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2655">
      <rect
         style="fill:#ff2a2a"
         id="rect2657"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2659">
      <rect
         style="fill:#ff2a2a"
         id="rect2661"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2663">
      <rect
         style="fill:#ff2a2a"
         id="rect2665"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2667">
      <rect
         style="fill:#ff2a2a"
         id="rect2669"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2671">
      <rect
         style="fill:#ff2a2a"
         id="rect2673"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2675">
      <rect
         style="fill:#ff2a2a"
         id="rect2677"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2679">
      <rect
         style="fill:#ff2a2a"
         id="rect2681"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2683">
      <rect
         style="fill:#ff2a2a"
         id="rect2685"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2687">
      <rect
         style="fill:#ff2a2a"
         id="rect2689"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2691">
      <rect
         style="fill:#ff2a2a"
         id="rect2693"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2695">
      <rect
         style="fill:#ff2a2a"
         id="rect2697"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2699">
      <rect
         style="fill:#ff2a2a"
         id="rect2701"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2703">
      <rect
         style="fill:#ff2a2a"
         id="rect2705"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2707">
      <rect
         style="fill:#ff2a2a"
         id="rect2709"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2711">
      <rect
         style="fill:#ff2a2a"
         id="rect2713"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2715">
      <rect
         style="fill:#ff2a2a"
         id="rect2717"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2719">
      <rect
         style="fill:#ff2a2a"
         id="rect2721"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2723">
      <rect
         style="fill:#ff2a2a"
         id="rect2725"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2727">
      <rect
         style="fill:#ff2a2a"
         id="rect2729"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2731">
      <rect
         style="fill:#ff2a2a"
         id="rect2733"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2735">
      <rect
         style="fill:#ff2a2a"
         id="rect2737"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2739">
      <rect
         style="fill:#ff2a2a"
         id="rect2741"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2743">
      <rect
         style="fill:#ff2a2a"
         id="rect2745"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2747">
      <rect
         style="fill:#ff2a2a"
         id="rect2749"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2751">
      <rect
         style="fill:#ff2a2a"
         id="rect2753"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2755">
      <rect
         style="fill:#ff2a2a"
         id="rect2757"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2759">
      <rect
         style="fill:#ff2a2a"
         id="rect2761"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2763">
      <rect
         style="fill:#ff2a2a"
         id="rect2765"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2767">
      <rect
         style="fill:#ff2a2a"
         id="rect2769"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2771">
      <rect
         style="fill:#ff2a2a"
         id="rect2773"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2775">
      <rect
         style="fill:#ff2a2a"
         id="rect2777"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2779">
      <rect
         style="fill:#ff2a2a"
         id="rect2781"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2783">
      <rect
         style="fill:#ff2a2a"
         id="rect2785"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2787">
      <rect
         style="fill:#ff2a2a"
         id="rect2789"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2791">
      <rect
         style="fill:#ff2a2a"
         id="rect2793"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2795">
      <rect
         style="fill:#ff2a2a"
         id="rect2797"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2799">
      <rect
         style="fill:#ff2a2a"
         id="rect2801"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2803">
      <rect
         style="fill:#ff2a2a"
         id="rect2805"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2807">
      <rect
         style="fill:#ff2a2a"
         id="rect2809"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2811">
      <rect
         style="fill:#ff2a2a"
         id="rect2813"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2815">
      <rect
         style="fill:#ff2a2a"
         id="rect2817"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2819">
      <rect
         style="fill:#ff2a2a"
         id="rect2821"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2823">
      <rect
         style="fill:#ff2a2a"
         id="rect2825"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2827">
      <rect
         style="fill:#ff2a2a"
         id="rect2829"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2831">
      <rect
         style="fill:#ff2a2a"
         id="rect2833"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2835">
      <rect
         style="fill:#ff2a2a"
         id="rect2837"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2839">
      <rect
         style="fill:#ff2a2a"
         id="rect2841"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2843">
      <rect
         style="fill:#ff2a2a"
         id="rect2845"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2847">
      <rect
         style="fill:#ff2a2a"
         id="rect2849"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2851">
      <rect
         style="fill:#ff2a2a"
         id="rect2853"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2855">
      <rect
         style="fill:#ff2a2a"
         id="rect2857"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2859">
      <rect
         style="fill:#ff2a2a"
         id="rect2861"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2863">
      <rect
         style="fill:#ff2a2a"
         id="rect2865"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2867">
      <rect
         style="fill:#ff2a2a"
         id="rect2869"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2871">
      <rect
         style="fill:#ff2a2a"
         id="rect2873"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2875">
      <rect
         style="fill:#ff2a2a"
         id="rect2877"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2879">
      <rect
         style="fill:#ff2a2a"
         id="rect2881"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2883">
      <rect
         style="fill:#ff2a2a"
         id="rect2885"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2887">
      <rect
         style="fill:#ff2a2a"
         id="rect2889"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2891">
      <rect
         style="fill:#ff2a2a"
         id="rect2893"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2895">
      <rect
         style="fill:#ff2a2a"
         id="rect2897"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2899">
      <rect
         style="fill:#ff2a2a"
         id="rect2901"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2903">
      <rect
         style="fill:#ff2a2a"
         id="rect2905"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2907">
      <rect
         style="fill:#ff2a2a"
         id="rect2909"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2911">
      <rect
         style="fill:#ff2a2a"
         id="rect2913"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2915">
      <rect
         style="fill:#ff2a2a"
         id="rect2917"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2919">
      <rect
         style="fill:#ff2a2a"
         id="rect2921"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2923">
      <rect
         style="fill:#ff2a2a"
         id="rect2925"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2927">
      <rect
         style="fill:#ff2a2a"
         id="rect2929"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2931">
      <rect
         style="fill:#ff2a2a"
         id="rect2933"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2935">
      <rect
         style="fill:#ff2a2a"
         id="rect2937"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2939">
      <rect
         style="fill:#ff2a2a"
         id="rect2941"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2943">
      <rect
         style="fill:#ff2a2a"
         id="rect2945"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2947">
      <rect
         style="fill:#ff2a2a"
         id="rect2949"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2951">
      <rect
         style="fill:#ff2a2a"
         id="rect2953"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2955">
      <rect
         style="fill:#ff2a2a"
         id="rect2957"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2959">
      <rect
         style="fill:#ff2a2a"
         id="rect2961"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2963">
      <rect
         style="fill:#ff2a2a"
         id="rect2965"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2967">
      <rect
         style="fill:#ff2a2a"
         id="rect2969"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2971">
      <rect
         style="fill:#ff2a2a"
         id="rect2973"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2975">
      <rect
         style="fill:#ff2a2a"
         id="rect2977"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2979">
      <rect
         style="fill:#ff2a2a"
         id="rect2981"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2983">
      <rect
         style="fill:#ff2a2a"
         id="rect2985"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2987">
      <rect
         style="fill:#ff2a2a"
         id="rect2989"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2991">
      <rect
         style="fill:#ff2a2a"
         id="rect2993"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2995">
      <rect
         style="fill:#ff2a2a"
         id="rect2997"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath2999">
      <rect
         style="fill:#ff2a2a"
         id="rect3001"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3003">
      <rect
         style="fill:#ff2a2a"
         id="rect3005"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3007">
      <rect
         style="fill:#ff2a2a"
         id="rect3009"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3011">
      <rect
         style="fill:#ff2a2a"
         id="rect3013"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3015">
      <rect
         style="fill:#ff2a2a"
         id="rect3017"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3019">
      <rect
         style="fill:#ff2a2a"
         id="rect3021"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3023">
      <rect
         style="fill:#ff2a2a"
         id="rect3025"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3027">
      <rect
         style="fill:#ff2a2a"
         id="rect3029"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3031">
      <rect
         style="fill:#ff2a2a"
         id="rect3033"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3035">
      <rect
         style="fill:#ff2a2a"
         id="rect3037"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3039">
      <rect
         style="fill:#ff2a2a"
         id="rect3041"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3043">
      <rect
         style="fill:#ff2a2a"
         id="rect3045"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3047">
      <rect
         style="fill:#ff2a2a"
         id="rect3049"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3051">
      <rect
         style="fill:#ff2a2a"
         id="rect3053"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3055">
      <rect
         style="fill:#ff2a2a"
         id="rect3057"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3059">
      <rect
         style="fill:#ff2a2a"
         id="rect3061"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3063">
      <rect
         style="fill:#ff2a2a"
         id="rect3065"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3067">
      <rect
         style="fill:#ff2a2a"
         id="rect3069"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3071">
      <rect
         style="fill:#ff2a2a"
         id="rect3073"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3075">
      <rect
         style="fill:#ff2a2a"
         id="rect3077"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3079">
      <rect
         style="fill:#ff2a2a"
         id="rect3081"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3083">
      <rect
         style="fill:#ff2a2a"
         id="rect3085"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3087">
      <rect
         style="fill:#ff2a2a"
         id="rect3089"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3091">
      <rect
         style="fill:#ff2a2a"
         id="rect3093"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3095">
      <rect
         style="fill:#ff2a2a"
         id="rect3097"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3099">
      <rect
         style="fill:#ff2a2a"
         id="rect3101"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3103">
      <rect
         style="fill:#ff2a2a"
         id="rect3105"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3107">
      <rect
         style="fill:#ff2a2a"
         id="rect3109"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3111">
      <rect
         style="fill:#ff2a2a"
         id="rect3113"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3115">
      <rect
         style="fill:#ff2a2a"
         id="rect3117"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3119">
      <rect
         style="fill:#ff2a2a"
         id="rect3121"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3123">
      <rect
         style="fill:#ff2a2a"
         id="rect3125"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3127">
      <rect
         style="fill:#ff2a2a"
         id="rect3129"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3131">
      <rect
         style="fill:#ff2a2a"
         id="rect3133"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3135">
      <rect
         style="fill:#ff2a2a"
         id="rect3137"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3139">
      <rect
         style="fill:#ff2a2a"
         id="rect3141"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3143">
      <rect
         style="fill:#ff2a2a"
         id="rect3145"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3147">
      <rect
         style="fill:#ff2a2a"
         id="rect3149"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3151">
      <rect
         style="fill:#ff2a2a"
         id="rect3153"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3155">
      <rect
         style="fill:#ff2a2a"
         id="rect3157"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3159">
      <rect
         style="fill:#ff2a2a"
         id="rect3161"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3163">
      <rect
         style="fill:#ff2a2a"
         id="rect3165"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3167">
      <rect
         style="fill:#ff2a2a"
         id="rect3169"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3171">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3173"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3175">
      <rect
         style="fill:#ff2a2a"
         id="rect3177"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3179">
      <rect
         style="fill:#ff2a2a"
         id="rect3181"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3183">
      <rect
         style="fill:#ff2a2a"
         id="rect3185"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3187">
      <rect
         style="fill:#ff2a2a"
         id="rect3189"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3191">
      <rect
         style="fill:#ff2a2a"
         id="rect3193"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3195">
      <rect
         style="fill:#ff2a2a"
         id="rect3197"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3199">
      <rect
         style="fill:#ff2a2a"
         id="rect3201"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3203">
      <rect
         style="fill:#ff2a2a"
         id="rect3205"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3207">
      <rect
         style="fill:#ff2a2a"
         id="rect3209"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3211">
      <rect
         style="fill:#ff2a2a"
         id="rect3213"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3215">
      <rect
         style="fill:#ff2a2a"
         id="rect3217"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3219">
      <rect
         style="fill:#ff2a2a"
         id="rect3221"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3223">
      <rect
         style="fill:#ff2a2a"
         id="rect3225"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3227">
      <rect
         style="fill:#ff2a2a"
         id="rect3229"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3231">
      <rect
         style="fill:#ff2a2a"
         id="rect3233"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3235">
      <rect
         style="fill:#ff2a2a"
         id="rect3237"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3239">
      <rect
         style="fill:#ff2a2a"
         id="rect3241"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3243">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3245"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3247">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3249"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3251">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3253"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3255">
      <rect
         style="fill:#ff2a2a"
         id="rect3257"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3259">
      <rect
         style="fill:#ff2a2a"
         id="rect3261"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3263">
      <rect
         style="fill:#ff2a2a"
         id="rect3265"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3267">
      <rect
         style="fill:#ff2a2a"
         id="rect3269"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3271">
      <rect
         style="fill:#ff2a2a"
         id="rect3273"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3275">
      <rect
         style="fill:#ff2a2a"
         id="rect3277"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3279">
      <rect
         style="fill:#ff2a2a"
         id="rect3281"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3283">
      <rect
         style="fill:#ff2a2a"
         id="rect3285"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3287">
      <rect
         style="fill:#ff2a2a"
         id="rect3289"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3291">
      <rect
         style="fill:#ff2a2a"
         id="rect3293"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3295">
      <rect
         style="fill:#ff2a2a"
         id="rect3297"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3299">
      <rect
         style="fill:#ff2a2a"
         id="rect3301"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3303">
      <rect
         style="fill:#ff2a2a"
         id="rect3305"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3307">
      <rect
         style="fill:#ff2a2a"
         id="rect3309"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3311">
      <rect
         style="fill:#ff2a2a"
         id="rect3313"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3315">
      <rect
         style="fill:#ff2a2a"
         id="rect3317"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3319">
      <rect
         style="fill:#ff2a2a"
         id="rect3321"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3323">
      <rect
         style="fill:#ff2a2a"
         id="rect3325"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3327">
      <rect
         style="fill:#ff2a2a"
         id="rect3329"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3331">
      <rect
         style="fill:#ff2a2a"
         id="rect3333"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3335">
      <rect
         style="fill:#ff2a2a"
         id="rect3337"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3339">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3341"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3343">
      <rect
         style="fill:#ff2a2a"
         id="rect3345"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3347">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3349"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3351">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3353"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3355">
      <rect
         style="fill:#ff2a2a"
         id="rect3357"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3359">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3361"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3363">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3365"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3367">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3369"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3371">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3373"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3375">
      <rect
         style="fill:#ff2a2a"
         id="rect3377"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3379">
      <rect
         style="fill:#ff2a2a"
         id="rect3381"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3383">
      <rect
         style="fill:#ff2a2a"
         id="rect3385"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3387">
      <rect
         style="fill:#ff2a2a"
         id="rect3389"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3391">
      <rect
         style="fill:#ff2a2a"
         id="rect3393"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3395">
      <rect
         style="fill:#ff2a2a"
         id="rect3397"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3399">
      <rect
         style="fill:#ff2a2a"
         id="rect3401"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3403">
      <rect
         style="fill:#ff2a2a"
         id="rect3405"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3407">
      <rect
         style="fill:#ff2a2a"
         id="rect3409"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3411">
      <rect
         style="fill:#ff2a2a"
         id="rect3413"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3415">
      <rect
         style="fill:#ff2a2a"
         id="rect3417"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3419">
      <rect
         style="fill:#ff2a2a"
         id="rect3421"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3423">
      <rect
         style="fill:#ff2a2a"
         id="rect3425"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3427">
      <rect
         style="fill:#ff2a2a"
         id="rect3429"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3431">
      <rect
         style="fill:#ff2a2a"
         id="rect3433"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3435">
      <rect
         style="fill:#ff2a2a"
         id="rect3437"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3439">
      <rect
         style="fill:#ff2a2a"
         id="rect3441"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3443">
      <rect
         style="fill:#ff2a2a"
         id="rect3445"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3447">
      <rect
         style="fill:#ff2a2a"
         id="rect3449"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3451">
      <rect
         style="fill:#ff2a2a"
         id="rect3453"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3455">
      <rect
         style="fill:#ff2a2a"
         id="rect3457"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3459">
      <rect
         style="fill:#ff2a2a"
         id="rect3461"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3463">
      <rect
         style="fill:#ff2a2a"
         id="rect3465"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3467">
      <rect
         style="fill:#ff2a2a"
         id="rect3469"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3471">
      <rect
         style="fill:#ff2a2a"
         id="rect3473"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3475">
      <rect
         style="fill:#ff2a2a"
         id="rect3477"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3479">
      <rect
         style="fill:#ff2a2a"
         id="rect3481"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3483">
      <rect
         style="fill:#ff2a2a"
         id="rect3485"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3487">
      <rect
         style="fill:#ff2a2a"
         id="rect3489"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3491">
      <rect
         style="fill:#ff2a2a"
         id="rect3493"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3495">
      <rect
         style="fill:#ff2a2a"
         id="rect3497"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3499">
      <rect
         style="fill:#ff2a2a"
         id="rect3501"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3503">
      <rect
         style="fill:#ff2a2a"
         id="rect3505"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3507">
      <rect
         style="fill:#ff2a2a"
         id="rect3509"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3511">
      <rect
         style="fill:#ff2a2a"
         id="rect3513"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3515">
      <rect
         style="fill:#ff2a2a"
         id="rect3517"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3519">
      <rect
         style="fill:#ff2a2a"
         id="rect3521"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3523">
      <rect
         style="fill:#ff2a2a"
         id="rect3525"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3527">
      <rect
         style="fill:#ff2a2a"
         id="rect3529"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3531">
      <rect
         style="fill:#ff2a2a"
         id="rect3533"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3535">
      <rect
         style="fill:#ff2a2a"
         id="rect3537"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3539">
      <rect
         style="fill:#ff2a2a"
         id="rect3541"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3543">
      <rect
         style="fill:#ff2a2a"
         id="rect3545"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3547">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3549"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3551">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect3553"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3555">
      <rect
         style="fill:#ff2a2a"
         id="rect3557"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3559">
      <rect
         style="fill:#ff2a2a"
         id="rect3561"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3563">
      <rect
         style="fill:#ff2a2a"
         id="rect3565"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3567">
      <rect
         style="fill:#ff2a2a"
         id="rect3569"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3571">
      <rect
         style="fill:#ff2a2a"
         id="rect3573"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3575">
      <rect
         style="fill:#ff2a2a"
         id="rect3577"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3579">
      <rect
         style="fill:#ff2a2a"
         id="rect3581"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3583">
      <rect
         style="fill:#ff2a2a"
         id="rect3585"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3587">
      <rect
         style="fill:#ff2a2a"
         id="rect3589"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3591">
      <rect
         style="fill:#ff2a2a"
         id="rect3593"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3595">
      <rect
         style="fill:#ff2a2a"
         id="rect3597"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3599">
      <rect
         style="fill:#ff2a2a"
         id="rect3601"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3603">
      <rect
         style="fill:#ff2a2a"
         id="rect3605"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3607">
      <rect
         style="fill:#ff2a2a"
         id="rect3609"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3611">
      <rect
         style="fill:#ff2a2a"
         id="rect3613"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3615">
      <rect
         style="fill:#ff2a2a"
         id="rect3617"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3619">
      <rect
         style="fill:#ff2a2a"
         id="rect3621"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3623">
      <rect
         style="fill:#ff2a2a"
         id="rect3625"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3627">
      <rect
         style="fill:#ff2a2a"
         id="rect3629"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3631">
      <rect
         style="fill:#ff2a2a"
         id="rect3633"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3635">
      <rect
         style="fill:#ff2a2a"
         id="rect3637"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3639">
      <rect
         style="fill:#ff2a2a"
         id="rect3641"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3643">
      <rect
         style="fill:#ff2a2a"
         id="rect3645"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3647">
      <rect
         style="fill:#ff2a2a"
         id="rect3649"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3651">
      <rect
         style="fill:#ff2a2a"
         id="rect3653"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3655">
      <rect
         style="fill:#ff2a2a"
         id="rect3657"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3659">
      <rect
         style="fill:#ff2a2a"
         id="rect3661"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3663">
      <rect
         style="fill:#ff2a2a"
         id="rect3665"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3667">
      <rect
         style="fill:#ff2a2a"
         id="rect3669"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3671">
      <rect
         style="fill:#ff2a2a"
         id="rect3673"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3675">
      <rect
         style="fill:#ff2a2a"
         id="rect3677"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3679">
      <rect
         style="fill:#ff2a2a"
         id="rect3681"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3683">
      <rect
         style="fill:#ff2a2a"
         id="rect3685"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3687">
      <rect
         style="fill:#ff2a2a"
         id="rect3689"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3691">
      <rect
         style="fill:#ff2a2a"
         id="rect3693"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3695">
      <rect
         style="fill:#ff2a2a"
         id="rect3697"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3699">
      <rect
         style="fill:#ff2a2a"
         id="rect3701"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3703">
      <rect
         style="fill:#ff2a2a"
         id="rect3705"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3707">
      <rect
         style="fill:#ff2a2a"
         id="rect3709"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3711">
      <rect
         style="fill:#ff2a2a"
         id="rect3713"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3715">
      <rect
         style="fill:#ff2a2a"
         id="rect3717"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3719">
      <rect
         style="fill:#ff2a2a"
         id="rect3721"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3723">
      <rect
         style="fill:#ff2a2a"
         id="rect3725"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3727">
      <rect
         style="fill:#ff2a2a"
         id="rect3729"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3731">
      <rect
         style="fill:#ff2a2a"
         id="rect3733"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3735">
      <rect
         style="fill:#ff2a2a"
         id="rect3737"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3739">
      <rect
         style="fill:#ff2a2a"
         id="rect3741"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3743">
      <rect
         style="fill:#ff2a2a"
         id="rect3745"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3747">
      <rect
         style="fill:#ff2a2a"
         id="rect3749"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3751">
      <rect
         style="fill:#ff2a2a"
         id="rect3753"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3755">
      <rect
         style="fill:#ff2a2a"
         id="rect3757"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3759">
      <rect
         style="fill:#ff2a2a"
         id="rect3761"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3763">
      <rect
         style="fill:#ff2a2a"
         id="rect3765"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3767">
      <rect
         style="fill:#ff2a2a"
         id="rect3769"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3771">
      <rect
         style="fill:#ff2a2a"
         id="rect3773"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3775">
      <rect
         style="fill:#ff2a2a"
         id="rect3777"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3779">
      <rect
         style="fill:#ff2a2a"
         id="rect3781"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3783">
      <rect
         style="fill:#ff2a2a"
         id="rect3785"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3787">
      <rect
         style="fill:#ff2a2a"
         id="rect3789"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3791">
      <rect
         style="fill:#ff2a2a"
         id="rect3793"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3795">
      <rect
         style="fill:#ff2a2a"
         id="rect3797"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3799">
      <rect
         style="fill:#ff2a2a"
         id="rect3801"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3803">
      <rect
         style="fill:#ff2a2a"
         id="rect3805"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3807">
      <rect
         style="fill:#ff2a2a"
         id="rect3809"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3811">
      <rect
         style="fill:#ff2a2a"
         id="rect3813"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3815">
      <rect
         style="fill:#ff2a2a"
         id="rect3817"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3819">
      <rect
         style="fill:#ff2a2a"
         id="rect3821"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3823">
      <rect
         style="fill:#ff2a2a"
         id="rect3825"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3827">
      <rect
         style="fill:#ff2a2a"
         id="rect3829"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3831">
      <rect
         style="fill:#ff2a2a"
         id="rect3833"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3835">
      <rect
         style="fill:#ff2a2a"
         id="rect3837"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3839">
      <rect
         style="fill:#ff2a2a"
         id="rect3841"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3843">
      <rect
         style="fill:#ff2a2a"
         id="rect3845"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3847">
      <rect
         style="fill:#ff2a2a"
         id="rect3849"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3851">
      <rect
         style="fill:#ff2a2a"
         id="rect3853"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3855">
      <rect
         style="fill:#ff2a2a"
         id="rect3857"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3859">
      <rect
         style="fill:#ff2a2a"
         id="rect3861"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3863">
      <rect
         style="fill:#ff2a2a"
         id="rect3865"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3867">
      <rect
         style="fill:#ff2a2a"
         id="rect3869"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3871">
      <rect
         style="fill:#ff2a2a"
         id="rect3873"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3875">
      <rect
         style="fill:#ff2a2a"
         id="rect3877"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3879">
      <rect
         style="fill:#ff2a2a"
         id="rect3881"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3883">
      <rect
         style="fill:#ff2a2a"
         id="rect3885"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3887">
      <rect
         style="fill:#ff2a2a"
         id="rect3889"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3891">
      <rect
         style="fill:#ff2a2a"
         id="rect3893"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3895">
      <rect
         style="fill:#ff2a2a"
         id="rect3897"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3899">
      <rect
         style="fill:#ff2a2a"
         id="rect3901"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3903">
      <rect
         style="fill:#ff2a2a"
         id="rect3905"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3907">
      <rect
         style="fill:#ff2a2a"
         id="rect3909"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3911">
      <rect
         style="fill:#ff2a2a"
         id="rect3913"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3915">
      <rect
         style="fill:#ff2a2a"
         id="rect3917"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3919">
      <rect
         style="fill:#ff2a2a"
         id="rect3921"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3923">
      <rect
         style="fill:#ff2a2a"
         id="rect3925"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3927">
      <rect
         style="fill:#ff2a2a"
         id="rect3929"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3931">
      <rect
         style="fill:#ff2a2a"
         id="rect3933"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3935">
      <rect
         style="fill:#ff2a2a"
         id="rect3937"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3939">
      <rect
         style="fill:#ff2a2a"
         id="rect3941"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3943">
      <rect
         style="fill:#ff2a2a"
         id="rect3945"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3947">
      <rect
         style="fill:#ff2a2a"
         id="rect3949"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3951">
      <rect
         style="fill:#ff2a2a"
         id="rect3953"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3955">
      <rect
         style="fill:#ff2a2a"
         id="rect3957"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3959">
      <rect
         style="fill:#ff2a2a"
         id="rect3961"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3963">
      <rect
         style="fill:#ff2a2a"
         id="rect3965"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3967">
      <rect
         style="fill:#ff2a2a"
         id="rect3969"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3971">
      <rect
         style="fill:#ff2a2a"
         id="rect3973"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3975">
      <rect
         style="fill:#ff2a2a"
         id="rect3977"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3979">
      <rect
         style="fill:#ff2a2a"
         id="rect3981"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3983">
      <rect
         style="fill:#ff2a2a"
         id="rect3985"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3987">
      <rect
         style="fill:#ff2a2a"
         id="rect3989"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3991">
      <rect
         style="fill:#ff2a2a"
         id="rect3993"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3995">
      <rect
         style="fill:#ff2a2a"
         id="rect3997"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath3999">
      <rect
         style="fill:#ff2a2a"
         id="rect4001"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4003">
      <rect
         style="fill:#ff2a2a"
         id="rect4005"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4007">
      <rect
         style="fill:#ff2a2a"
         id="rect4009"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4011">
      <rect
         style="fill:#ff2a2a"
         id="rect4013"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4015">
      <rect
         style="fill:#ff2a2a"
         id="rect4017"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4019">
      <rect
         style="fill:#ff2a2a"
         id="rect4021"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4023">
      <rect
         style="fill:#ff2a2a"
         id="rect4025"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4027">
      <rect
         style="fill:#ff2a2a"
         id="rect4029"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4031">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4033"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4035">
      <rect
         style="fill:#ff2a2a"
         id="rect4037"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4039">
      <rect
         style="fill:#ff2a2a"
         id="rect4041"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4043">
      <rect
         style="fill:#ff2a2a"
         id="rect4045"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4047">
      <rect
         style="fill:#ff2a2a"
         id="rect4049"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4051">
      <rect
         style="fill:#ff2a2a"
         id="rect4053"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4055">
      <rect
         style="fill:#ff2a2a"
         id="rect4057"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4059">
      <rect
         style="fill:#ff2a2a"
         id="rect4061"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4063">
      <rect
         style="fill:#ff2a2a"
         id="rect4065"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4067">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4069"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4071">
      <rect
         style="fill:#ff2a2a"
         id="rect4073"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4075">
      <rect
         style="fill:#ff2a2a"
         id="rect4077"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4079">
      <rect
         style="fill:#ff2a2a"
         id="rect4081"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4083">
      <rect
         style="fill:#ff2a2a"
         id="rect4085"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4087">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4089"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4091">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4093"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4095">
      <rect
         style="fill:#ff2a2a"
         id="rect4097"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4099">
      <rect
         style="fill:#ff2a2a"
         id="rect4101"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4103">
      <rect
         style="fill:#ff2a2a"
         id="rect4105"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4107">
      <rect
         style="fill:#ff2a2a"
         id="rect4109"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4111">
      <rect
         style="fill:#ff2a2a"
         id="rect4113"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4115">
      <rect
         style="fill:#ff2a2a"
         id="rect4117"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4119">
      <rect
         style="fill:#ff2a2a"
         id="rect4121"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4123">
      <rect
         style="fill:#ff2a2a"
         id="rect4125"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4127">
      <rect
         style="fill:#ff2a2a"
         id="rect4129"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4131">
      <rect
         style="fill:#ff2a2a"
         id="rect4133"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4135">
      <rect
         style="fill:#ff2a2a"
         id="rect4137"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4139">
      <rect
         style="fill:#ff2a2a"
         id="rect4141"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4143">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4145"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4147">
      <rect
         style="fill:#ff2a2a"
         id="rect4149"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4151">
      <rect
         style="fill:#ff2a2a"
         id="rect4153"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4155">
      <rect
         style="fill:#ff2a2a"
         id="rect4157"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4159">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4161"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4163">
      <rect
         style="fill:#ff2a2a"
         id="rect4165"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4167">
      <rect
         style="fill:#ff2a2a"
         id="rect4169"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4171">
      <rect
         style="fill:#ff2a2a"
         id="rect4173"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4175">
      <rect
         style="fill:#ff2a2a"
         id="rect4177"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4179">
      <rect
         style="fill:#ff2a2a"
         id="rect4181"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4183">
      <rect
         style="fill:#ff2a2a"
         id="rect4185"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4187">
      <rect
         style="fill:#ff2a2a"
         id="rect4189"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4191">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4193"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4195">
      <rect
         style="fill:#ff2a2a"
         id="rect4197"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4199">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4201"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4203">
      <rect
         style="fill:#ff2a2a"
         id="rect4205"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4207">
      <rect
         style="fill:#ff2a2a"
         id="rect4209"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4211">
      <rect
         style="fill:#ff2a2a"
         id="rect4213"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4215">
      <rect
         style="fill:#ff2a2a"
         id="rect4217"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4219">
      <rect
         style="fill:#ff2a2a"
         id="rect4221"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4223">
      <rect
         style="fill:#ff2a2a"
         id="rect4225"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4227">
      <rect
         style="fill:#ff2a2a"
         id="rect4229"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4231">
      <rect
         style="fill:#ff2a2a"
         id="rect4233"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4235">
      <rect
         style="fill:#ff2a2a"
         id="rect4237"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4239">
      <rect
         style="fill:#ff2a2a"
         id="rect4241"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4243">
      <rect
         style="fill:#ff2a2a;stroke-width:10"
         id="rect4245"
         width="4829.7173"
         height="6099.0195"
         x="641.8045"
         y="-7830.6919"
         transform="scale(1,-1)" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4247">
      <rect
         style="fill:#ff2a2a"
         id="rect4249"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4251">
      <rect
         style="fill:#ff2a2a"
         id="rect4253"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4255">
      <rect
         style="fill:#ff2a2a"
         id="rect4257"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4259">
      <rect
         style="fill:#ff2a2a"
         id="rect4261"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4263">
      <rect
         style="fill:#ff2a2a"
         id="rect4265"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4267">
      <rect
         style="fill:#ff2a2a"
         id="rect4269"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4271">
      <rect
         style="fill:#ff2a2a"
         id="rect4273"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4275">
      <rect
         style="fill:#ff2a2a"
         id="rect4277"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4279">
      <rect
         style="fill:#ff2a2a"
         id="rect4281"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4283">
      <rect
         style="fill:#ff2a2a"
         id="rect4285"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4287">
      <rect
         style="fill:#ff2a2a"
         id="rect4289"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4291">
      <rect
         style="fill:#ff2a2a"
         id="rect4293"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4295">
      <rect
         style="fill:#ff2a2a"
         id="rect4297"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4299">
      <rect
         style="fill:#ff2a2a"
         id="rect4301"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4303">
      <rect
         style="fill:#ff2a2a"
         id="rect4305"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4307">
      <rect
         style="fill:#ff2a2a"
         id="rect4309"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4311">
      <rect
         style="fill:#ff2a2a"
         id="rect4313"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4315">
      <rect
         style="fill:#ff2a2a"
         id="rect4317"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4319">
      <rect
         style="fill:#ff2a2a"
         id="rect4321"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4323">
      <rect
         style="fill:#ff2a2a"
         id="rect4325"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4327">
      <rect
         style="fill:#ff2a2a"
         id="rect4329"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4331">
      <rect
         style="fill:#ff2a2a"
         id="rect4333"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4335">
      <rect
         style="fill:#ff2a2a"
         id="rect4337"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4339">
      <rect
         style="fill:#ff2a2a"
         id="rect4341"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4343">
      <rect
         style="fill:#ff2a2a"
         id="rect4345"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4347">
      <rect
         style="fill:#ff2a2a"
         id="rect4349"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4351">
      <rect
         style="fill:#ff2a2a"
         id="rect4353"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4355">
      <rect
         style="fill:#ff2a2a"
         id="rect4357"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4359">
      <rect
         style="fill:#ff2a2a"
         id="rect4361"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4363">
      <rect
         style="fill:#ff2a2a"
         id="rect4365"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4367">
      <rect
         style="fill:#ff2a2a"
         id="rect4369"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4371">
      <rect
         style="fill:#ff2a2a"
         id="rect4373"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4375">
      <rect
         style="fill:#ff2a2a"
         id="rect4377"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4379">
      <rect
         style="fill:#ff2a2a"
         id="rect4381"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4383">
      <rect
         style="fill:#ff2a2a"
         id="rect4385"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4387">
      <rect
         style="fill:#ff2a2a"
         id="rect4389"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4391">
      <rect
         style="fill:#ff2a2a"
         id="rect4393"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4395">
      <rect
         style="fill:#ff2a2a"
         id="rect4397"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4399">
      <rect
         style="fill:#ff2a2a"
         id="rect4401"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4403">
      <rect
         style="fill:#ff2a2a"
         id="rect4405"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4407">
      <rect
         style="fill:#ff2a2a"
         id="rect4409"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4411">
      <rect
         style="fill:#ff2a2a"
         id="rect4413"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4415">
      <rect
         style="fill:#ff2a2a"
         id="rect4417"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4419">
      <rect
         style="fill:#ff2a2a"
         id="rect4421"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4423">
      <rect
         style="fill:#ff2a2a"
         id="rect4425"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4427">
      <rect
         style="fill:#ff2a2a"
         id="rect4429"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4431">
      <rect
         style="fill:#ff2a2a"
         id="rect4433"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4435">
      <rect
         style="fill:#ff2a2a"
         id="rect4437"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4439">
      <rect
         style="fill:#ff2a2a"
         id="rect4441"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4443">
      <rect
         style="fill:#ff2a2a"
         id="rect4445"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4447">
      <rect
         style="fill:#ff2a2a"
         id="rect4449"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4451">
      <rect
         style="fill:#ff2a2a"
         id="rect4453"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4455">
      <rect
         style="fill:#ff2a2a"
         id="rect4457"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4459">
      <rect
         style="fill:#ff2a2a"
         id="rect4461"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4463">
      <rect
         style="fill:#ff2a2a"
         id="rect4465"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4467">
      <rect
         style="fill:#ff2a2a"
         id="rect4469"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4471">
      <rect
         style="fill:#ff2a2a"
         id="rect4473"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
    <clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath4475">
      <rect
         style="fill:#ff2a2a"
         id="rect4477"
         width="482.97171"
         height="609.90198"
         x="64.18045"
         y="58.930801" />
    </clipPath>
  </defs>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g613"
     clip-path="url(#clipPath4475)">
    <use
       xlink:href="#glyph-0-1"
       x="115.623"
       y="45.235"
       id="use611" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g619"
     clip-path="url(#clipPath4471)">
    <use
       xlink:href="#glyph-0-2"
       x="122.998284"
       y="45.235"
       id="use615" />
    <use
       xlink:href="#glyph-0-3"
       x="126.009196"
       y="45.235"
       id="use617" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g623"
     clip-path="url(#clipPath4467)">
    <use
       xlink:href="#glyph-0-4"
       x="132.035255"
       y="45.235"
       id="use621" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g627"
     clip-path="url(#clipPath4463)">
    <use
       xlink:href="#glyph-0-5"
       x="135.347776"
       y="45.235"
       id="use625" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g631"
     clip-path="url(#clipPath4459)">
    <use
       xlink:href="#glyph-0-6"
       x="141.373823"
       y="45.235"
       id="use629" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g635"
     clip-path="url(#clipPath4455)">
    <use
       xlink:href="#glyph-0-7"
       x="147.399882"
       y="45.235"
       id="use633" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g639"
     clip-path="url(#clipPath4451)">
    <use
       xlink:href="#glyph-0-8"
       x="151.623522"
       y="45.235"
       id="use637" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g643"
     clip-path="url(#clipPath4447)">
    <use
       xlink:href="#glyph-0-3"
       x="157.649581"
       y="45.235"
       id="use641" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g647"
     clip-path="url(#clipPath4443)">
    <use
       xlink:href="#glyph-0-9"
       x="163.675628"
       y="45.235"
       id="use645" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g653"
     clip-path="url(#clipPath4439)">
    <use
       xlink:href="#glyph-0-2"
       x="172.691999"
       y="45.235"
       id="use649" />
    <use
       xlink:href="#glyph-0-3"
       x="175.702911"
       y="45.235"
       id="use651" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g657"
     clip-path="url(#clipPath4435)">
    <use
       xlink:href="#glyph-0-10"
       x="185.346861"
       y="45.235"
       id="use655" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g663"
     clip-path="url(#clipPath4431)">
    <use
       xlink:href="#glyph-0-2"
       x="191.37292"
       y="45.235"
       id="use659" />
    <use
       xlink:href="#glyph-0-11"
       x="194.383831"
       y="45.235"
       id="use661" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g667"
     clip-path="url(#clipPath4427)">
    <use
       xlink:href="#glyph-0-12"
       x="202.817406"
       y="45.235"
       id="use665" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g671"
     clip-path="url(#clipPath4423)">
    <use
       xlink:href="#glyph-0-13"
       x="212.754448"
       y="45.235"
       id="use669" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g675"
     clip-path="url(#clipPath4419)">
    <use
       xlink:href="#glyph-0-14"
       x="218.179689"
       y="45.235"
       id="use673" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g679"
     clip-path="url(#clipPath4415)">
    <use
       xlink:href="#glyph-0-11"
       x="222.403366"
       y="45.235"
       id="use677" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g683"
     clip-path="url(#clipPath4411)">
    <use
       xlink:href="#glyph-0-7"
       x="227.227801"
       y="45.235"
       id="use681" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g689"
     clip-path="url(#clipPath4407)">
    <use
       xlink:href="#glyph-0-2"
       x="231.451454"
       y="45.235"
       id="use685" />
    <use
       xlink:href="#glyph-0-13"
       x="234.462365"
       y="45.235"
       id="use687" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g695"
     clip-path="url(#clipPath4403)">
    <use
       xlink:href="#glyph-0-15"
       x="239.88763"
       y="45.235"
       id="use691" />
    <use
       xlink:href="#glyph-0-16"
       x="242.898542"
       y="45.235"
       id="use693" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g699"
     clip-path="url(#clipPath4399)">
    <use
       xlink:href="#glyph-0-17"
       x="251.930471"
       y="45.235"
       id="use697" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g703"
     clip-path="url(#clipPath4395)">
    <use
       xlink:href="#glyph-0-10"
       x="257.652832"
       y="45.235"
       id="use701" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g707"
     clip-path="url(#clipPath4391)">
    <use
       xlink:href="#glyph-0-11"
       x="263.678879"
       y="45.235"
       id="use705" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g717"
     clip-path="url(#clipPath4387)">
    <use
       xlink:href="#glyph-0-15"
       x="268.503313"
       y="45.235"
       id="use709" />
    <use
       xlink:href="#glyph-0-15"
       x="271.514225"
       y="45.235"
       id="use711" />
    <use
       xlink:href="#glyph-0-2"
       x="274.525136"
       y="45.235"
       id="use713" />
    <use
       xlink:href="#glyph-0-11"
       x="277.536048"
       y="45.235"
       id="use715" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g721"
     clip-path="url(#clipPath4383)">
    <use
       xlink:href="#glyph-0-7"
       x="282.360482"
       y="45.235"
       id="use719" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g725"
     clip-path="url(#clipPath4379)">
    <use
       xlink:href="#glyph-0-8"
       x="286.584135"
       y="45.235"
       id="use723" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g729"
     clip-path="url(#clipPath4375)">
    <use
       xlink:href="#glyph-0-3"
       x="292.610182"
       y="45.235"
       id="use727" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g733"
     clip-path="url(#clipPath4371)">
    <use
       xlink:href="#glyph-0-9"
       x="298.636229"
       y="45.235"
       id="use731" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g737"
     clip-path="url(#clipPath4367)">
    <use
       xlink:href="#glyph-0-18"
       x="307.643382"
       y="45.235"
       id="use735" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g741"
     clip-path="url(#clipPath4363)">
    <use
       xlink:href="#glyph-0-19"
       x="316.677589"
       y="45.235"
       id="use739" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g745"
     clip-path="url(#clipPath4359)">
    <use
       xlink:href="#glyph-0-20"
       x="324.801329"
       y="45.235"
       id="use743" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g749"
     clip-path="url(#clipPath4355)">
    <use
       xlink:href="#glyph-0-8"
       x="330.827376"
       y="45.235"
       id="use747" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g753"
     clip-path="url(#clipPath4351)">
    <use
       xlink:href="#glyph-0-3"
       x="336.853398"
       y="45.235"
       id="use751" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g757"
     clip-path="url(#clipPath4347)">
    <use
       xlink:href="#glyph-0-9"
       x="342.879445"
       y="45.235"
       id="use755" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g761"
     clip-path="url(#clipPath4343)">
    <use
       xlink:href="#glyph-0-21"
       x="348.30471"
       y="45.235"
       id="use759" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g765"
     clip-path="url(#clipPath4339)">
    <use
       xlink:href="#glyph-0-8"
       x="352.576683"
       y="45.235"
       id="use763" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g769"
     clip-path="url(#clipPath4335)">
    <use
       xlink:href="#glyph-0-3"
       x="358.602729"
       y="45.235"
       id="use767" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g773"
     clip-path="url(#clipPath4331)">
    <use
       xlink:href="#glyph-0-14"
       x="364.331803"
       y="45.235"
       id="use771" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g777"
     clip-path="url(#clipPath4327)">
    <use
       xlink:href="#glyph-0-11"
       x="368.555455"
       y="45.235"
       id="use775" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g781"
     clip-path="url(#clipPath4323)">
    <use
       xlink:href="#glyph-0-7"
       x="373.37989"
       y="45.235"
       id="use779" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g787"
     clip-path="url(#clipPath4319)">
    <use
       xlink:href="#glyph-0-15"
       x="377.603543"
       y="45.235"
       id="use783" />
    <use
       xlink:href="#glyph-0-13"
       x="380.614454"
       y="45.235"
       id="use785" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g791"
     clip-path="url(#clipPath4315)">
    <use
       xlink:href="#glyph-0-9"
       x="386.039719"
       y="45.235"
       id="use789" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g795"
     clip-path="url(#clipPath4311)">
    <use
       xlink:href="#glyph-0-11"
       x="391.464984"
       y="45.235"
       id="use793" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g799"
     clip-path="url(#clipPath4307)">
    <use
       xlink:href="#glyph-0-3"
       x="396.289419"
       y="45.235"
       id="use797" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g803"
     clip-path="url(#clipPath4303)">
    <use
       xlink:href="#glyph-0-18"
       x="405.897554"
       y="45.235"
       id="use801" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g807"
     clip-path="url(#clipPath4299)">
    <use
       xlink:href="#glyph-0-22"
       x="414.93174"
       y="45.235"
       id="use805" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g811"
     clip-path="url(#clipPath4295)">
    <use
       xlink:href="#glyph-0-23"
       x="430.596728"
       y="45.235"
       id="use809" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g815"
     clip-path="url(#clipPath4291)">
    <use
       xlink:href="#glyph-0-7"
       x="437.972012"
       y="45.235"
       id="use813" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g819"
     clip-path="url(#clipPath4287)">
    <use
       xlink:href="#glyph-0-17"
       x="442.19564"
       y="45.235"
       id="use817" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g823"
     clip-path="url(#clipPath4283)">
    <use
       xlink:href="#glyph-0-4"
       x="447.620881"
       y="45.235"
       id="use821" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g827"
     clip-path="url(#clipPath4279)">
    <use
       xlink:href="#glyph-0-24"
       x="450.93339"
       y="45.235"
       id="use825" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g831"
     clip-path="url(#clipPath4275)">
    <use
       xlink:href="#glyph-0-25"
       x="457.553391"
       y="45.235"
       id="use829" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g835"
     clip-path="url(#clipPath4271)">
    <use
       xlink:href="#glyph-0-24"
       x="465.957"
       y="45.235"
       id="use833" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g839"
     clip-path="url(#clipPath4267)">
    <use
       xlink:href="#glyph-0-26"
       x="472.594773"
       y="45.235"
       id="use837" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g843"
     clip-path="url(#clipPath4263)">
    <use
       xlink:href="#glyph-0-13"
       x="480.271459"
       y="45.235"
       id="use841" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g849"
     clip-path="url(#clipPath4259)">
    <use
       xlink:href="#glyph-0-15"
       x="485.6967"
       y="45.235"
       id="use845" />
    <use
       xlink:href="#glyph-0-27"
       x="488.707611"
       y="45.235"
       id="use847" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g853"
     clip-path="url(#clipPath4255)">
    <use
       xlink:href="#glyph-0-13"
       x="493.53207"
       y="45.235"
       id="use851" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g857"
     clip-path="url(#clipPath4251)">
    <use
       xlink:href="#glyph-0-3"
       x="498.957311"
       y="45.235"
       id="use855" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g861"
     clip-path="url(#clipPath4247)">
    <use
       xlink:href="#glyph-0-2"
       x="504.983333"
       y="45.235"
       id="use859" />
  </g>
  <path
     fill="none"
     stroke-width="4.05"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 850.390625 7925.039062 L 5385.859375 7925.039062 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path863"
     clip-path="url(#clipPath4243)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g867"
     clip-path="url(#clipPath4239)">
    <use
       xlink:href="#glyph-1-1"
       x="255.114"
       y="70.966"
       id="use865" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g871"
     clip-path="url(#clipPath4235)">
    <use
       xlink:href="#glyph-1-2"
       x="267.868529"
       y="70.966"
       id="use869" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g875"
     clip-path="url(#clipPath4231)">
    <use
       xlink:href="#glyph-1-3"
       x="274.405625"
       y="70.966"
       id="use873" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g879"
     clip-path="url(#clipPath4227)">
    <use
       xlink:href="#glyph-1-4"
       x="281.511349"
       y="70.966"
       id="use877" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g883"
     clip-path="url(#clipPath4223)">
    <use
       xlink:href="#glyph-1-5"
       x="290.840986"
       y="70.966"
       id="use881" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g893"
     clip-path="url(#clipPath4219)">
    <use
       xlink:href="#glyph-1-6"
       x="296.97676"
       y="70.966"
       id="use885" />
    <use
       xlink:href="#glyph-1-6"
       x="300.706751"
       y="70.966"
       id="use887" />
    <use
       xlink:href="#glyph-1-7"
       x="304.436742"
       y="70.966"
       id="use889" />
    <use
       xlink:href="#glyph-1-1"
       x="311.155508"
       y="70.966"
       id="use891" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g897"
     clip-path="url(#clipPath4215)">
    <use
       xlink:href="#glyph-1-8"
       x="323.910013"
       y="70.966"
       id="use895" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g903"
     clip-path="url(#clipPath4211)">
    <use
       xlink:href="#glyph-1-9"
       x="331.006952"
       y="70.966"
       id="use899" />
    <use
       xlink:href="#glyph-1-5"
       x="338.478889"
       y="70.966"
       id="use901" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g907"
     clip-path="url(#clipPath4207)">
    <use
       xlink:href="#glyph-1-6"
       x="344.614687"
       y="70.966"
       id="use905" />
  </g>
  <g
     clip-path="url(#clipPath4203)"
     id="g911">
    <path
       fill="none"
       stroke-width="4.25182"
       stroke-linecap="round"
       stroke-linejoin="round"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 2558.242188 7383.554688 L 2622.304688 7383.554688 L 2638.203125 7447.617188 L 2669.960938 7320.078125 L 2701.679688 7447.617188 L 2733.4375 7320.078125 L 2765.742188 7447.617188 L 2797.5 7320.078125 L 2829.257812 7447.617188 L 2860.976562 7320.078125 L 2893.28125 7447.617188 L 2925.039062 7320.078125 L 2940.9375 7383.554688 L 3323.59375 7383.554688 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path909" />
  </g>
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 3323.59375 7434.023438 L 3323.59375 7334.257812 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path913"
     clip-path="url(#clipPath4199)" />
  <g
     clip-path="url(#clipPath4195)"
     id="g917">
    <path
       fill="none"
       stroke-width="4.25182"
       stroke-linecap="round"
       stroke-linejoin="round"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 3196.054688 7320.078125 L 3419.414062 7320.078125 L 3419.414062 7447.617188 L 3196.054688 7447.617188 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path915" />
  </g>
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 3419.414062 7383.554688 L 3546.953125 7383.554688 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path919"
     clip-path="url(#clipPath4191)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g923"
     clip-path="url(#clipPath4187)">
    <use
       xlink:href="#glyph-2-1"
       x="274.959"
       y="93.646"
       id="use921" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g927"
     clip-path="url(#clipPath4183)">
    <use
       xlink:href="#glyph-2-2"
       x="331.649994"
       y="93.646"
       id="use925" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g931"
     clip-path="url(#clipPath4179)">
    <use
       xlink:href="#glyph-3-1"
       x="257.211"
       y="150.337"
       id="use929" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g935"
     clip-path="url(#clipPath4175)">
    <use
       xlink:href="#glyph-4-1"
       x="255.11413"
       y="150.337"
       id="use933" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g939"
     clip-path="url(#clipPath4171)">
    <use
       xlink:href="#glyph-3-2"
       x="263.91608"
       y="150.337"
       id="use937" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g943"
     clip-path="url(#clipPath4167)">
    <use
       xlink:href="#glyph-3-1"
       x="280.59308"
       y="142.24598"
       id="use941" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g947"
     clip-path="url(#clipPath4163)">
    <use
       xlink:href="#glyph-4-2"
       x="278.67589"
       y="142.24598"
       id="use945" />
  </g>
  <path
     fill="none"
     stroke-width="4.86"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 2775.429688 6946.601562 L 2869.101562 6946.601562 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path949"
     clip-path="url(#clipPath4159)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g953"
     clip-path="url(#clipPath4155)">
    <use
       xlink:href="#glyph-4-3"
       x="277.542"
       y="158.536"
       id="use951" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g957"
     clip-path="url(#clipPath4151)">
    <use
       xlink:href="#glyph-3-3"
       x="290.7537"
       y="150.33717"
       id="use955" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g961"
     clip-path="url(#clipPath4147)">
    <use
       xlink:href="#glyph-4-2"
       x="303.7139"
       y="142.24615"
       id="use959" />
  </g>
  <path
     fill="none"
     stroke-width="4.86"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 3037.148438 6946.601562 L 3107.96875 6946.601562 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path963"
     clip-path="url(#clipPath4143)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g967"
     clip-path="url(#clipPath4139)">
    <use
       xlink:href="#glyph-4-4"
       x="304.155"
       y="158.536"
       id="use965" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g971"
     clip-path="url(#clipPath4135)">
    <use
       xlink:href="#glyph-5-1"
       x="345.8249"
       y="150.33717"
       id="use969" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g975"
     clip-path="url(#clipPath4131)">
    <use
       xlink:href="#glyph-5-2"
       x="350.382576"
       y="150.33717"
       id="use973" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g979"
     clip-path="url(#clipPath4127)">
    <use
       xlink:href="#glyph-5-3"
       x="356.227033"
       y="150.33717"
       id="use977" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g983"
     clip-path="url(#clipPath4123)">
    <use
       xlink:href="#glyph-5-4"
       x="359.476965"
       y="150.33717"
       id="use981" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g987"
     clip-path="url(#clipPath4119)">
    <use
       xlink:href="#glyph-5-5"
       x="365.321422"
       y="150.33717"
       id="use985" />
  </g>
  <g
     clip-path="url(#clipPath4115)"
     id="g993">
    <g
       clip-path="url(#clip-3)"
       id="g991">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2702.695312 5681.835938 L 3638.085938 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path989" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 355.242188 275.707031 L 362.800781 273.816406 L 355.242188 271.925781 Z M 355.242188 275.707031 "
     id="path995"
     clip-path="url(#clipPath4111)" />
  <g
     clip-path="url(#clipPath4107)"
     id="g999">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 3552.421875 5662.929688 L 3628.007812 5681.835938 L 3552.421875 5700.742188 Z M 3552.421875 5662.929688 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path997" />
  </g>
  <g
     clip-path="url(#clipPath4103)"
     id="g1005">
    <g
       clip-path="url(#clip-6)"
       id="g1003">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2787.734375 6532.1875 L 2787.734375 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1001" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 280.660156 197.347656 L 278.773438 189.789062 L 276.882812 197.347656 Z M 280.660156 197.347656 "
     id="path1007"
     clip-path="url(#clipPath4099)" />
  <g
     clip-path="url(#clipPath4095)"
     id="g1011">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 2806.601562 6446.523438 L 2787.734375 6522.109375 L 2768.828125 6446.523438 Z M 2806.601562 6446.523438 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1009" />
  </g>
  <path
     fill="none"
     stroke-width="4.72425"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 2759.375 5851.914062 L 2816.054688 5851.914062 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1013"
     clip-path="url(#clipPath4091)" />
  <path
     fill="none"
     stroke-width="18.897"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(82.03125%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 2787.734375 5681.835938 L 2787.734375 5851.914062 L 3553.046875 6333.789062 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1015"
     clip-path="url(#clipPath4087)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1019"
     clip-path="url(#clipPath4083)">
    <use
       xlink:href="#glyph-4-1"
       x="264.564"
       y="197.326"
       id="use1017" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1023"
     clip-path="url(#clipPath4079)">
    <use
       xlink:href="#glyph-4-5"
       x="355.2839"
       y="288.0373"
       id="use1021" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1027"
     clip-path="url(#clipPath4075)">
    <use
       xlink:href="#glyph-6-1"
       x="266.976"
       y="254.98"
       id="use1025" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1031"
     clip-path="url(#clipPath4071)">
    <use
       xlink:href="#glyph-2-3"
       x="266.526"
       y="254.98"
       id="use1029" />
  </g>
  <path
     fill="none"
     stroke-width="4.86"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 2657.617188 5853.007812 L 2724.21875 5853.007812 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1033"
     clip-path="url(#clipPath4067)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1037"
     clip-path="url(#clipPath4063)">
    <use
       xlink:href="#glyph-2-1"
       x="265.761"
       y="263.809"
       id="use1035" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1041"
     clip-path="url(#clipPath4059)">
    <use
       xlink:href="#glyph-4-1"
       x="255.1141"
       y="306.2442"
       id="use1039" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1045"
     clip-path="url(#clipPath4055)">
    <use
       xlink:href="#glyph-3-4"
       x="260.59496"
       y="306.2442"
       id="use1043" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1049"
     clip-path="url(#clipPath4051)">
    <use
       xlink:href="#glyph-3-5"
       x="265.148958"
       y="306.2442"
       id="use1047" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1053"
     clip-path="url(#clipPath4047)">
    <use
       xlink:href="#glyph-3-6"
       x="270.998932"
       y="306.2442"
       id="use1051" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1057"
     clip-path="url(#clipPath4043)">
    <use
       xlink:href="#glyph-3-2"
       x="278.873816"
       y="306.2442"
       id="use1055" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1061"
     clip-path="url(#clipPath4039)">
    <use
       xlink:href="#glyph-3-7"
       x="294.25516"
       y="298.15318"
       id="use1059" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1065"
     clip-path="url(#clipPath4035)">
    <use
       xlink:href="#glyph-4-2"
       x="293.634066"
       y="298.15318"
       id="use1063" />
  </g>
  <path
     fill="none"
     stroke-width="4.86"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 2925 5387.539062 L 3018.671875 5387.539062 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1067"
     clip-path="url(#clipPath4031)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1071"
     clip-path="url(#clipPath4027)">
    <use
       xlink:href="#glyph-4-3"
       x="292.5"
       y="314.443"
       id="use1069" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1075"
     clip-path="url(#clipPath4023)">
    <use
       xlink:href="#glyph-4-1"
       x="255.1141"
       y="328.9149"
       id="use1073" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1079"
     clip-path="url(#clipPath4019)">
    <use
       xlink:href="#glyph-3-4"
       x="260.59496"
       y="328.9149"
       id="use1077" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1083"
     clip-path="url(#clipPath4015)">
    <use
       xlink:href="#glyph-7-1"
       x="265.14887"
       y="328.9149"
       id="use1081" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1087"
     clip-path="url(#clipPath4011)">
    <use
       xlink:href="#glyph-3-6"
       x="277.10087"
       y="328.9149"
       id="use1085" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1091"
     clip-path="url(#clipPath4007)">
    <use
       xlink:href="#glyph-7-2"
       x="284.97587"
       y="328.9149"
       id="use1089" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1095"
     clip-path="url(#clipPath4003)">
    <use
       xlink:href="#glyph-7-1"
       x="300.248857"
       y="328.9149"
       id="use1093" />
  </g>
  <g
     clip-path="url(#clipPath3999)"
     id="g1101">
    <g
       clip-path="url(#clip-9)"
       id="g1099">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2786.835938 4689.726562 L 2786.835938 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1097" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 280.574219 381.59375 L 278.683594 374.035156 L 276.796875 381.59375 Z M 280.574219 381.59375 "
     id="path1103"
     clip-path="url(#clipPath3995)" />
  <g
     clip-path="url(#clipPath3991)"
     id="g1107">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 2805.742188 4604.0625 L 2786.835938 4679.648438 L 2767.96875 4604.0625 Z M 2805.742188 4604.0625 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1105" />
  </g>
  <g
     clip-path="url(#clipPath3987)"
     id="g1113">
    <g
       clip-path="url(#clip-12)"
       id="g1111">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 3637.226562 3839.335938 L 2701.835938 3839.335938 Z M 3637.226562 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1109" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3983)"
     id="g1119">
    <g
       clip-path="url(#clip-14)"
       id="g1117">
      <path
         fill-rule="evenodd"
         fill="rgb(0%, 0%, 0%)"
         fill-opacity="1"
         d="M 355.15625 459.953125 L 362.714844 458.066406 L 355.15625 456.175781 Z M 355.15625 459.953125 "
         id="path1115" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3979)"
     id="g1125">
    <g
       clip-path="url(#clip-16)"
       id="g1123">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="butt"
         stroke-linejoin="miter"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 3551.5625 3820.46875 L 3627.148438 3839.335938 L 3551.5625 3858.242188 Z M 3551.5625 3820.46875 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1121" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3975)"
     id="g1131">
    <g
       clip-path="url(#clip-18)"
       id="g1129">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2758.515625 4406.25 L 2815.195312 4406.25 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1127" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3971)"
     id="g1137">
    <g
       clip-path="url(#clip-20)"
       id="g1135">
      <path
         fill="none"
         stroke-width="18.897"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(82.03125%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2786.835938 3839.335938 L 2786.835938 4406.25 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1133" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3967)"
     id="g1143">
    <g
       clip-path="url(#clip-22)"
       id="g1141">
      <path
         fill="none"
         stroke-width="18.897"
         stroke-linecap="round"
         stroke-linejoin="bevel"
         stroke="rgb(82.03125%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 2786.835938 4406.25 L 2786.835938 4405.625 L 2787.460938 4403.75 L 2788.125 4398.710938 L 2789.375 4389.882812 L 2791.875 4377.929688 L 2794.414062 4364.0625 L 2796.914062 4348.320312 L 2800.078125 4331.914062 L 2802.617188 4316.835938 L 2805.742188 4302.34375 L 2808.28125 4289.101562 L 2810.78125 4277.148438 L 2812.695312 4266.445312 L 2815.195312 4255.703125 L 2817.734375 4246.289062 L 2820.234375 4236.171875 L 2822.148438 4226.09375 L 2825.273438 4216.640625 L 2827.8125 4206.601562 L 2830.9375 4195.898438 L 2834.101562 4185.15625 L 2837.890625 4174.453125 L 2841.640625 4163.125 L 2854.882812 4131.015625 L 2859.921875 4120.273438 L 2864.960938 4110.195312 L 2870 4100.742188 L 2875.039062 4091.953125 L 2880.078125 4083.125 L 2885.742188 4074.921875 L 2891.40625 4066.757812 L 2897.695312 4058.554688 L 2904.648438 4050.351562 L 2911.5625 4042.1875 L 2919.140625 4033.984375 L 2927.304688 4025.78125 L 2936.132812 4017.617188 L 2944.335938 4010.039062 L 2953.789062 4001.875 L 2962.578125 3994.921875 L 2972.03125 3988.007812 L 2980.859375 3981.09375 L 2990.3125 3974.765625 L 3007.96875 3963.4375 L 3016.757812 3958.398438 L 3025.585938 3953.984375 L 3034.414062 3948.945312 L 3043.867188 3944.53125 L 3053.945312 3939.492188 L 3064.023438 3935.117188 L 3074.101562 3930.703125 L 3084.804688 3926.289062 L 3096.132812 3922.5 L 3106.835938 3918.085938 L 3118.164062 3914.296875 L 3128.90625 3911.171875 L 3139.609375 3907.382812 L 3150.3125 3904.21875 L 3160.390625 3901.71875 L 3169.84375 3899.21875 L 3179.921875 3896.054688 L 3190 3894.140625 L 3200.078125 3891.640625 L 3210.15625 3889.101562 L 3220.859375 3886.601562 L 3232.1875 3884.0625 L 3242.890625 3882.1875 L 3254.882812 3879.6875 L 3266.210938 3877.773438 L 3278.164062 3875.273438 L 3289.492188 3873.359375 L 3300.859375 3871.484375 L 3311.5625 3869.609375 L 3322.265625 3867.695312 L 3342.421875 3865.195312 L 3351.875 3863.28125 L 3361.328125 3862.03125 L 3371.40625 3860.78125 L 3381.484375 3859.492188 L 3392.1875 3858.242188 L 3403.515625 3856.992188 L 3416.132812 3855.742188 L 3429.335938 3854.453125 L 3443.828125 3852.578125 L 3458.945312 3851.328125 L 3474.0625 3849.414062 L 3487.304688 3848.164062 L 3498.632812 3846.914062 L 3506.835938 3846.289062 L 3511.25 3845.664062 L 3513.75 3845.664062 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1139" />
    </g>
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1147"
     clip-path="url(#clipPath3963)">
    <use
       xlink:href="#glyph-4-2"
       x="264.564"
       y="381.574"
       id="use1145" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1151"
     clip-path="url(#clipPath3959)">
    <use
       xlink:href="#glyph-4-5"
       x="355.2839"
       y="472.2853"
       id="use1149" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1155"
     clip-path="url(#clipPath3955)">
    <use
       xlink:href="#glyph-4-3"
       x="256.0589"
       y="404.254"
       id="use1153" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1159"
     clip-path="url(#clipPath3951)">
    <use
       xlink:href="#glyph-3-7"
       x="268.2089"
       y="404.254"
       id="use1157" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1163"
     clip-path="url(#clipPath3947)">
    <use
       xlink:href="#glyph-4-1"
       x="267.426087"
       y="404.254"
       id="use1161" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1167"
     clip-path="url(#clipPath3943)">
    <use
       xlink:href="#glyph-4-2"
       x="255.114"
       y="490.492"
       id="use1165" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1171"
     clip-path="url(#clipPath3939)">
    <use
       xlink:href="#glyph-3-4"
       x="262.19681"
       y="490.492"
       id="use1169" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1175"
     clip-path="url(#clipPath3935)">
    <use
       xlink:href="#glyph-3-5"
       x="266.750808"
       y="490.492"
       id="use1173" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1179"
     clip-path="url(#clipPath3931)">
    <use
       xlink:href="#glyph-3-6"
       x="272.600782"
       y="490.492"
       id="use1177" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1183"
     clip-path="url(#clipPath3927)">
    <use
       xlink:href="#glyph-3-2"
       x="280.475666"
       y="490.492"
       id="use1181" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1187"
     clip-path="url(#clipPath3923)">
    <use
       xlink:href="#glyph-4-3"
       x="292.90461"
       y="490.492"
       id="use1185" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1191"
     clip-path="url(#clipPath3919)">
    <use
       xlink:href="#glyph-3-7"
       x="305.05461"
       y="490.492"
       id="use1189" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1195"
     clip-path="url(#clipPath3915)">
    <use
       xlink:href="#glyph-4-1"
       x="304.262422"
       y="490.492"
       id="use1193" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1199"
     clip-path="url(#clipPath3911)">
    <use
       xlink:href="#glyph-4-2"
       x="255.114022"
       y="513.1721"
       id="use1197" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1203"
     clip-path="url(#clipPath3907)">
    <use
       xlink:href="#glyph-3-4"
       x="262.196832"
       y="513.1721"
       id="use1201" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1207"
     clip-path="url(#clipPath3903)">
    <use
       xlink:href="#glyph-7-1"
       x="266.750742"
       y="513.1721"
       id="use1205" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1211"
     clip-path="url(#clipPath3899)">
    <use
       xlink:href="#glyph-3-6"
       x="278.702742"
       y="513.1721"
       id="use1209" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1215"
     clip-path="url(#clipPath3895)">
    <use
       xlink:href="#glyph-3-2"
       x="286.577722"
       y="513.1721"
       id="use1213" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1219"
     clip-path="url(#clipPath3891)">
    <use
       xlink:href="#glyph-3-5"
       x="299.006567"
       y="513.1721"
       id="use1217" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1223"
     clip-path="url(#clipPath3887)">
    <use
       xlink:href="#glyph-5-6"
       x="85.040742"
       y="150.3371"
       id="use1221" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1227"
     clip-path="url(#clipPath3883)">
    <use
       xlink:href="#glyph-5-7"
       x="95.768696"
       y="150.3371"
       id="use1225" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1231"
     clip-path="url(#clipPath3879)">
    <use
       xlink:href="#glyph-5-8"
       x="101.61316"
       y="150.3371"
       id="use1229" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1235"
     clip-path="url(#clipPath3875)">
    <use
       xlink:href="#glyph-5-9"
       x="106.170824"
       y="150.3371"
       id="use1233" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1239"
     clip-path="url(#clipPath3871)">
    <use
       xlink:href="#glyph-5-10"
       x="111.371866"
       y="150.3371"
       id="use1237" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1243"
     clip-path="url(#clipPath3867)">
    <use
       xlink:href="#glyph-5-11"
       x="115.929542"
       y="150.3371"
       id="use1241" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1247"
     clip-path="url(#clipPath3863)">
    <use
       xlink:href="#glyph-5-7"
       x="119.179462"
       y="150.3371"
       id="use1245" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1251"
     clip-path="url(#clipPath3859)">
    <use
       xlink:href="#glyph-5-12"
       x="125.023931"
       y="150.3371"
       id="use1249" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1255"
     clip-path="url(#clipPath3855)">
    <use
       xlink:href="#glyph-5-13"
       x="132.170654"
       y="150.3371"
       id="use1253" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1259"
     clip-path="url(#clipPath3851)">
    <use
       xlink:href="#glyph-5-7"
       x="139.482732"
       y="150.3371"
       id="use1257" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1263"
     clip-path="url(#clipPath3847)">
    <use
       xlink:href="#glyph-5-14"
       x="145.00319"
       y="150.3371"
       id="use1261" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1267"
     clip-path="url(#clipPath3843)">
    <use
       xlink:href="#glyph-5-15"
       x="153.454152"
       y="150.3371"
       id="use1265" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1271"
     clip-path="url(#clipPath3839)">
    <use
       xlink:href="#glyph-1-10"
       x="85.040742"
       y="173.0168"
       id="use1269" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1275"
     clip-path="url(#clipPath3835)">
    <use
       xlink:href="#glyph-1-11"
       x="94.225738"
       y="173.0168"
       id="use1273" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1279"
     clip-path="url(#clipPath3831)">
    <use
       xlink:href="#glyph-1-5"
       x="99.711231"
       y="173.0168"
       id="use1277" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1283"
     clip-path="url(#clipPath3827)">
    <use
       xlink:href="#glyph-1-12"
       x="105.847004"
       y="173.0168"
       id="use1281" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1289"
     clip-path="url(#clipPath3823)">
    <use
       xlink:href="#glyph-1-13"
       x="111.152286"
       y="173.0168"
       id="use1285" />
    <use
       xlink:href="#glyph-1-11"
       x="117.129836"
       y="173.0168"
       id="use1287" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1295"
     clip-path="url(#clipPath3819)">
    <use
       xlink:href="#glyph-1-14"
       x="122.615334"
       y="173.0168"
       id="use1291" />
    <use
       xlink:href="#glyph-1-15"
       x="126.345326"
       y="173.0168"
       id="use1293" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1299"
     clip-path="url(#clipPath3815)">
    <use
       xlink:href="#glyph-1-5"
       x="134.19546"
       y="173.0168"
       id="use1297" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1303"
     clip-path="url(#clipPath3811)">
    <use
       xlink:href="#glyph-1-9"
       x="140.331246"
       y="173.0168"
       id="use1301" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1311"
     clip-path="url(#clipPath3807)">
    <use
       xlink:href="#glyph-1-16"
       x="152.276029"
       y="173.0168"
       id="use1305" />
    <use
       xlink:href="#glyph-1-17"
       x="159.747967"
       y="173.0168"
       id="use1307" />
    <use
       xlink:href="#glyph-1-11"
       x="164.972345"
       y="173.0168"
       id="use1309" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1315"
     clip-path="url(#clipPath3803)">
    <use
       xlink:href="#glyph-1-5"
       x="170.457844"
       y="173.0168"
       id="use1313" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1319"
     clip-path="url(#clipPath3799)">
    <use
       xlink:href="#glyph-1-12"
       x="176.59363"
       y="173.0168"
       id="use1317" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1323"
     clip-path="url(#clipPath3795)">
    <use
       xlink:href="#glyph-1-12"
       x="181.898899"
       y="173.0168"
       id="use1321" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1327"
     clip-path="url(#clipPath3791)">
    <use
       xlink:href="#glyph-1-18"
       x="187.204181"
       y="173.0168"
       id="use1325" />
  </g>
  <g
     clip-path="url(#clipPath3787)"
     id="g1333">
    <g
       clip-path="url(#clip-24)"
       id="g1331">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 1001.132812 6532.1875 L 1001.132812 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1329" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 102.003906 197.347656 L 100.113281 189.789062 L 98.222656 197.347656 Z M 102.003906 197.347656 "
     id="path1335"
     clip-path="url(#clipPath3783)" />
  <g
     clip-path="url(#clipPath3779)"
     id="g1339">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 1020.039062 6446.523438 L 1001.132812 6522.109375 L 982.226562 6446.523438 Z M 1020.039062 6446.523438 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1337" />
  </g>
  <g
     clip-path="url(#clipPath3775)"
     id="g1345">
    <g
       clip-path="url(#clip-27)"
       id="g1343">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 1851.484375 5681.835938 L 916.09375 5681.835938 Z M 1851.484375 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1341" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3771)"
     id="g1351">
    <g
       clip-path="url(#clip-29)"
       id="g1349">
      <path
         fill-rule="evenodd"
         fill="rgb(0%, 0%, 0%)"
         fill-opacity="1"
         d="M 176.582031 275.707031 L 184.140625 273.816406 L 176.582031 271.925781 Z M 176.582031 275.707031 "
         id="path1347" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3767)"
     id="g1357">
    <g
       clip-path="url(#clip-31)"
       id="g1355">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="butt"
         stroke-linejoin="miter"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 1765.820312 5662.929688 L 1841.40625 5681.835938 L 1765.820312 5700.742188 Z M 1765.820312 5662.929688 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1353" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3763)"
     id="g1363">
    <g
       clip-path="url(#clip-33)"
       id="g1361">
      <path
         fill="none"
         stroke-width="18.897"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 82.03125%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 1001.132812 5681.835938 L 1001.132812 6248.75 L 1766.445312 6248.75 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1359" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3759)"
     id="g1369">
    <g
       clip-path="url(#clip-35)"
       id="g1367">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 972.773438 6248.75 L 1029.453125 6248.75 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1365" />
    </g>
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1373"
     clip-path="url(#clipPath3755)">
    <use
       xlink:href="#glyph-4-2"
       x="85.9859"
       y="197.326"
       id="use1371" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1377"
     clip-path="url(#clipPath3751)">
    <use
       xlink:href="#glyph-4-5"
       x="176.6968"
       y="288.0373"
       id="use1375" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1381"
     clip-path="url(#clipPath3747)">
    <use
       xlink:href="#glyph-3-7"
       x="86.598"
       y="219.9971"
       id="use1379" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1385"
     clip-path="url(#clipPath3743)">
    <use
       xlink:href="#glyph-4-2"
       x="85.985891"
       y="219.9971"
       id="use1383" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1389"
     clip-path="url(#clipPath3739)">
    <use
       xlink:href="#glyph-5-16"
       x="85.041"
       y="306.244"
       id="use1387" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1393"
     clip-path="url(#clipPath3735)">
    <use
       xlink:href="#glyph-5-17"
       x="89.260162"
       y="306.244"
       id="use1391" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1397"
     clip-path="url(#clipPath3731)">
    <use
       xlink:href="#glyph-5-11"
       x="95.759952"
       y="306.244"
       id="use1395" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1401"
     clip-path="url(#clipPath3727)">
    <use
       xlink:href="#glyph-5-8"
       x="99.009871"
       y="306.244"
       id="use1399" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1405"
     clip-path="url(#clipPath3723)">
    <use
       xlink:href="#glyph-5-11"
       x="103.567535"
       y="306.244"
       id="use1403" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1409"
     clip-path="url(#clipPath3719)">
    <use
       xlink:href="#glyph-5-7"
       x="106.817455"
       y="306.244"
       id="use1407" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1413"
     clip-path="url(#clipPath3715)">
    <use
       xlink:href="#glyph-5-12"
       x="112.661924"
       y="306.244"
       id="use1411" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1417"
     clip-path="url(#clipPath3711)">
    <use
       xlink:href="#glyph-5-18"
       x="119.818008"
       y="306.244"
       id="use1415" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1421"
     clip-path="url(#clipPath3707)">
    <use
       xlink:href="#glyph-5-9"
       x="128.104223"
       y="306.244"
       id="use1419" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1425"
     clip-path="url(#clipPath3703)">
    <use
       xlink:href="#glyph-5-19"
       x="133.305265"
       y="306.244"
       id="use1423" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1429"
     clip-path="url(#clipPath3699)">
    <use
       xlink:href="#glyph-5-7"
       x="139.805055"
       y="306.244"
       id="use1427" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1433"
     clip-path="url(#clipPath3695)">
    <use
       xlink:href="#glyph-5-20"
       x="145.325368"
       y="306.244"
       id="use1431" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1437"
     clip-path="url(#clipPath3691)">
    <use
       xlink:href="#glyph-5-11"
       x="151.503494"
       y="306.244"
       id="use1435" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1441"
     clip-path="url(#clipPath3687)">
    <use
       xlink:href="#glyph-5-21"
       x="154.753413"
       y="306.244"
       id="use1439" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1445"
     clip-path="url(#clipPath3683)">
    <use
       xlink:href="#glyph-5-10"
       x="160.597882"
       y="306.244"
       id="use1443" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1449"
     clip-path="url(#clipPath3679)">
    <use
       xlink:href="#glyph-5-15"
       x="165.155559"
       y="306.244"
       id="use1447" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1453"
     clip-path="url(#clipPath3675)">
    <use
       xlink:href="#glyph-5-22"
       x="85.041"
       y="328.9147"
       id="use1451" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1457"
     clip-path="url(#clipPath3671)">
    <use
       xlink:href="#glyph-5-11"
       x="92.683788"
       y="328.9147"
       id="use1455" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1461"
     clip-path="url(#clipPath3667)">
    <use
       xlink:href="#glyph-5-17"
       x="95.933707"
       y="328.9147"
       id="use1459" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1465"
     clip-path="url(#clipPath3663)">
    <use
       xlink:href="#glyph-5-7"
       x="102.43351"
       y="328.9147"
       id="use1463" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1469"
     clip-path="url(#clipPath3659)">
    <use
       xlink:href="#glyph-5-12"
       x="108.277979"
       y="328.9147"
       id="use1467" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1473"
     clip-path="url(#clipPath3655)">
    <use
       xlink:href="#glyph-5-18"
       x="115.433848"
       y="328.9147"
       id="use1471" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1477"
     clip-path="url(#clipPath3651)">
    <use
       xlink:href="#glyph-5-9"
       x="123.720062"
       y="328.9147"
       id="use1475" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1481"
     clip-path="url(#clipPath3647)">
    <use
       xlink:href="#glyph-5-19"
       x="128.921105"
       y="328.9147"
       id="use1479" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1485"
     clip-path="url(#clipPath3643)">
    <use
       xlink:href="#glyph-5-7"
       x="135.420895"
       y="328.9147"
       id="use1483" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1489"
     clip-path="url(#clipPath3639)">
    <use
       xlink:href="#glyph-5-20"
       x="140.941208"
       y="328.9147"
       id="use1487" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1493"
     clip-path="url(#clipPath3635)">
    <use
       xlink:href="#glyph-5-11"
       x="147.119333"
       y="328.9147"
       id="use1491" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1497"
     clip-path="url(#clipPath3631)">
    <use
       xlink:href="#glyph-5-21"
       x="150.369253"
       y="328.9147"
       id="use1495" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1501"
     clip-path="url(#clipPath3627)">
    <use
       xlink:href="#glyph-5-10"
       x="156.213722"
       y="328.9147"
       id="use1499" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1505"
     clip-path="url(#clipPath3623)">
    <use
       xlink:href="#glyph-5-15"
       x="160.771398"
       y="328.9147"
       id="use1503" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1509"
     clip-path="url(#clipPath3619)">
    <use
       xlink:href="#glyph-1-10"
       x="85.041"
       y="357.2647"
       id="use1507" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1513"
     clip-path="url(#clipPath3615)">
    <use
       xlink:href="#glyph-1-11"
       x="94.225996"
       y="357.2647"
       id="use1511" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1517"
     clip-path="url(#clipPath3611)">
    <use
       xlink:href="#glyph-1-5"
       x="99.711489"
       y="357.2647"
       id="use1515" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1521"
     clip-path="url(#clipPath3607)">
    <use
       xlink:href="#glyph-1-12"
       x="105.847262"
       y="357.2647"
       id="use1519" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1527"
     clip-path="url(#clipPath3603)">
    <use
       xlink:href="#glyph-1-13"
       x="111.152544"
       y="357.2647"
       id="use1523" />
    <use
       xlink:href="#glyph-1-11"
       x="117.130094"
       y="357.2647"
       id="use1525" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1533"
     clip-path="url(#clipPath3599)">
    <use
       xlink:href="#glyph-1-14"
       x="122.615592"
       y="357.2647"
       id="use1529" />
    <use
       xlink:href="#glyph-1-15"
       x="126.345584"
       y="357.2647"
       id="use1531" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1537"
     clip-path="url(#clipPath3595)">
    <use
       xlink:href="#glyph-1-5"
       x="134.195718"
       y="357.2647"
       id="use1535" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1541"
     clip-path="url(#clipPath3591)">
    <use
       xlink:href="#glyph-1-9"
       x="140.331504"
       y="357.2647"
       id="use1539" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1549"
     clip-path="url(#clipPath3587)">
    <use
       xlink:href="#glyph-1-16"
       x="152.276287"
       y="357.2647"
       id="use1543" />
    <use
       xlink:href="#glyph-1-17"
       x="159.748225"
       y="357.2647"
       id="use1545" />
    <use
       xlink:href="#glyph-1-11"
       x="164.972603"
       y="357.2647"
       id="use1547" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1553"
     clip-path="url(#clipPath3583)">
    <use
       xlink:href="#glyph-1-2"
       x="170.458102"
       y="357.2647"
       id="use1551" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1561"
     clip-path="url(#clipPath3579)">
    <use
       xlink:href="#glyph-1-14"
       x="176.995198"
       y="357.2647"
       id="use1555" />
    <use
       xlink:href="#glyph-1-19"
       x="180.725189"
       y="357.2647"
       id="use1557" />
    <use
       xlink:href="#glyph-1-18"
       x="188.197127"
       y="357.2647"
       id="use1559" />
  </g>
  <g
     clip-path="url(#clipPath3575)"
     id="g1567">
    <g
       clip-path="url(#clip-37)"
       id="g1565">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 916.914062 3839.335938 L 1852.304688 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1563" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 176.664062 459.953125 L 184.222656 458.066406 L 176.664062 456.175781 Z M 176.664062 459.953125 "
     id="path1569"
     clip-path="url(#clipPath3571)" />
  <g
     clip-path="url(#clipPath3567)"
     id="g1573">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 1766.640625 3820.46875 L 1842.226562 3839.335938 L 1766.640625 3858.242188 Z M 1766.640625 3820.46875 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1571" />
  </g>
  <g
     clip-path="url(#clipPath3563)"
     id="g1579">
    <g
       clip-path="url(#clip-40)"
       id="g1577">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 1001.953125 4689.726562 L 1001.953125 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1575" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 102.085938 381.59375 L 100.195312 374.035156 L 98.304688 381.59375 Z M 102.085938 381.59375 "
     id="path1581"
     clip-path="url(#clipPath3559)" />
  <g
     clip-path="url(#clipPath3555)"
     id="g1585">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 1020.859375 4604.0625 L 1001.953125 4679.648438 L 983.046875 4604.0625 Z M 1020.859375 4604.0625 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1583" />
  </g>
  <path
     fill="none"
     stroke-width="4.72425"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 973.59375 4406.25 L 1030.273438 4406.25 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1587"
     clip-path="url(#clipPath3551)" />
  <path
     fill="none"
     stroke-width="18.897"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 82.03125%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 1001.953125 3839.335938 L 1001.953125 4406.25 L 1767.265625 4406.25 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1589"
     clip-path="url(#clipPath3547)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1593"
     clip-path="url(#clipPath3543)">
    <use
       xlink:href="#glyph-4-1"
       x="85.9859"
       y="381.574"
       id="use1591" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1597"
     clip-path="url(#clipPath3539)">
    <use
       xlink:href="#glyph-4-5"
       x="176.6968"
       y="472.2853"
       id="use1595" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1601"
     clip-path="url(#clipPath3535)">
    <use
       xlink:href="#glyph-3-7"
       x="86.7781"
       y="404.254"
       id="use1599" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1605"
     clip-path="url(#clipPath3531)">
    <use
       xlink:href="#glyph-4-1"
       x="85.985912"
       y="404.254"
       id="use1603" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1609"
     clip-path="url(#clipPath3527)">
    <use
       xlink:href="#glyph-5-16"
       x="85.04099"
       y="490.4919"
       id="use1607" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1613"
     clip-path="url(#clipPath3523)">
    <use
       xlink:href="#glyph-5-17"
       x="89.260152"
       y="490.4919"
       id="use1611" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1617"
     clip-path="url(#clipPath3519)">
    <use
       xlink:href="#glyph-5-11"
       x="95.759942"
       y="490.4919"
       id="use1615" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1621"
     clip-path="url(#clipPath3515)">
    <use
       xlink:href="#glyph-5-8"
       x="99.009861"
       y="490.4919"
       id="use1619" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1625"
     clip-path="url(#clipPath3511)">
    <use
       xlink:href="#glyph-5-11"
       x="103.567525"
       y="490.4919"
       id="use1623" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1629"
     clip-path="url(#clipPath3507)">
    <use
       xlink:href="#glyph-5-7"
       x="106.817445"
       y="490.4919"
       id="use1627" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1633"
     clip-path="url(#clipPath3503)">
    <use
       xlink:href="#glyph-5-12"
       x="112.661914"
       y="490.4919"
       id="use1631" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1637"
     clip-path="url(#clipPath3499)">
    <use
       xlink:href="#glyph-5-18"
       x="119.817998"
       y="490.4919"
       id="use1635" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1641"
     clip-path="url(#clipPath3495)">
    <use
       xlink:href="#glyph-5-9"
       x="128.104213"
       y="490.4919"
       id="use1639" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1645"
     clip-path="url(#clipPath3491)">
    <use
       xlink:href="#glyph-5-19"
       x="133.305255"
       y="490.4919"
       id="use1643" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1649"
     clip-path="url(#clipPath3487)">
    <use
       xlink:href="#glyph-5-7"
       x="139.805045"
       y="490.4919"
       id="use1647" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1653"
     clip-path="url(#clipPath3483)">
    <use
       xlink:href="#glyph-5-20"
       x="145.325358"
       y="490.4919"
       id="use1651" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1657"
     clip-path="url(#clipPath3479)">
    <use
       xlink:href="#glyph-5-11"
       x="151.503484"
       y="490.4919"
       id="use1655" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1661"
     clip-path="url(#clipPath3475)">
    <use
       xlink:href="#glyph-5-21"
       x="154.753403"
       y="490.4919"
       id="use1659" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1665"
     clip-path="url(#clipPath3471)">
    <use
       xlink:href="#glyph-5-10"
       x="160.597872"
       y="490.4919"
       id="use1663" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1669"
     clip-path="url(#clipPath3467)">
    <use
       xlink:href="#glyph-5-15"
       x="165.155549"
       y="490.4919"
       id="use1667" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1673"
     clip-path="url(#clipPath3463)">
    <use
       xlink:href="#glyph-5-22"
       x="85.04099"
       y="513.172"
       id="use1671" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1677"
     clip-path="url(#clipPath3459)">
    <use
       xlink:href="#glyph-5-11"
       x="92.683778"
       y="513.172"
       id="use1675" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1681"
     clip-path="url(#clipPath3455)">
    <use
       xlink:href="#glyph-5-17"
       x="95.933697"
       y="513.172"
       id="use1679" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1685"
     clip-path="url(#clipPath3451)">
    <use
       xlink:href="#glyph-5-7"
       x="102.4335"
       y="513.172"
       id="use1683" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1689"
     clip-path="url(#clipPath3447)">
    <use
       xlink:href="#glyph-5-12"
       x="108.277969"
       y="513.172"
       id="use1687" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1693"
     clip-path="url(#clipPath3443)">
    <use
       xlink:href="#glyph-5-18"
       x="115.433838"
       y="513.172"
       id="use1691" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1697"
     clip-path="url(#clipPath3439)">
    <use
       xlink:href="#glyph-5-9"
       x="123.720052"
       y="513.172"
       id="use1695" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1701"
     clip-path="url(#clipPath3435)">
    <use
       xlink:href="#glyph-5-19"
       x="128.921095"
       y="513.172"
       id="use1699" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1705"
     clip-path="url(#clipPath3431)">
    <use
       xlink:href="#glyph-5-7"
       x="135.420885"
       y="513.172"
       id="use1703" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1709"
     clip-path="url(#clipPath3427)">
    <use
       xlink:href="#glyph-5-20"
       x="140.941198"
       y="513.172"
       id="use1707" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1713"
     clip-path="url(#clipPath3423)">
    <use
       xlink:href="#glyph-5-11"
       x="147.119323"
       y="513.172"
       id="use1711" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1717"
     clip-path="url(#clipPath3419)">
    <use
       xlink:href="#glyph-5-21"
       x="150.369243"
       y="513.172"
       id="use1715" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1721"
     clip-path="url(#clipPath3415)">
    <use
       xlink:href="#glyph-5-10"
       x="156.213712"
       y="513.172"
       id="use1719" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1725"
     clip-path="url(#clipPath3411)">
    <use
       xlink:href="#glyph-5-15"
       x="160.771388"
       y="513.172"
       id="use1723" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1729"
     clip-path="url(#clipPath3407)">
    <use
       xlink:href="#glyph-1-20"
       x="411.02099"
       y="70.966"
       id="use1727" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1733"
     clip-path="url(#clipPath3403)">
    <use
       xlink:href="#glyph-1-5"
       x="421.55607"
       y="70.966"
       id="use1731" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1739"
     clip-path="url(#clipPath3399)">
    <use
       xlink:href="#glyph-1-6"
       x="427.691868"
       y="70.966"
       id="use1735" />
    <use
       xlink:href="#glyph-1-21"
       x="431.421859"
       y="70.966"
       id="use1737" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1749"
     clip-path="url(#clipPath3395)">
    <use
       xlink:href="#glyph-1-14"
       x="438.527632"
       y="70.966"
       id="use1741" />
    <use
       xlink:href="#glyph-1-19"
       x="442.257623"
       y="70.966"
       id="use1743" />
    <use
       xlink:href="#glyph-1-7"
       x="449.729561"
       y="70.966"
       id="use1745" />
    <use
       xlink:href="#glyph-1-22"
       x="456.448327"
       y="70.966"
       id="use1747" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1759"
     clip-path="url(#clipPath3391)">
    <use
       xlink:href="#glyph-1-8"
       x="465.471356"
       y="70.966"
       id="use1751" />
    <use
       xlink:href="#glyph-1-14"
       x="472.190122"
       y="70.966"
       id="use1753" />
    <use
       xlink:href="#glyph-1-23"
       x="475.920114"
       y="70.966"
       id="use1755" />
    <use
       xlink:href="#glyph-1-17"
       x="482.63888"
       y="70.966"
       id="use1757" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1763"
     clip-path="url(#clipPath3387)">
    <use
       xlink:href="#glyph-1-1"
       x="492.345417"
       y="70.966"
       id="use1761" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1767"
     clip-path="url(#clipPath3383)">
    <use
       xlink:href="#glyph-1-8"
       x="505.099946"
       y="70.966"
       id="use1765" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1773"
     clip-path="url(#clipPath3379)">
    <use
       xlink:href="#glyph-1-9"
       x="512.19664"
       y="70.966"
       id="use1769" />
    <use
       xlink:href="#glyph-1-5"
       x="519.668578"
       y="70.966"
       id="use1771" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1777"
     clip-path="url(#clipPath3375)">
    <use
       xlink:href="#glyph-1-6"
       x="525.804327"
       y="70.966"
       id="use1775" />
  </g>
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4244.648438 7503.710938 L 4372.1875 7503.710938 L 4388.085938 7567.773438 L 4419.804688 7440.234375 L 4451.5625 7567.773438 L 4483.320312 7440.234375 L 4515.625 7567.773438 L 4547.382812 7440.234375 L 4579.101562 7567.773438 L 4610.859375 7440.234375 L 4643.164062 7567.773438 L 4674.921875 7440.234375 L 4690.78125 7503.710938 L 4818.359375 7503.710938 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1779"
     clip-path="url(#clipPath3371)" />
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4244.648438 7185.117188 L 4244.648438 7503.710938 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1781"
     clip-path="url(#clipPath3367)" />
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4818.359375 7503.710938 L 4818.359375 7185.117188 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1783"
     clip-path="url(#clipPath3363)" />
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4659.0625 7185.117188 L 4818.359375 7185.117188 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1785"
     clip-path="url(#clipPath3359)" />
  <g
     clip-path="url(#clipPath3355)"
     id="g1789">
    <path
       fill="none"
       stroke-width="4.25182"
       stroke-linecap="round"
       stroke-linejoin="round"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 4435.703125 7121.601562 L 4659.0625 7121.601562 L 4659.0625 7249.179688 L 4435.703125 7249.179688 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1787" />
  </g>
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4563.242188 7185.117188 L 4244.648438 7185.117188 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1791"
     clip-path="url(#clipPath3351)" />
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4564.375 7232.734375 L 4564.375 7136.367188 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1793"
     clip-path="url(#clipPath3347)" />
  <g
     clip-path="url(#clipPath3343)"
     id="g1797">
    <path
       fill="none"
       stroke-width="4.25182"
       stroke-linecap="round"
       stroke-linejoin="round"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 4244.648438 7350.664062 L 4117.109375 7350.664062 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1795" />
  </g>
  <path
     fill="none"
     stroke-width="4.25182"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4946.484375 7350.664062 L 4818.90625 7350.664062 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1799"
     clip-path="url(#clipPath3339)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1803"
     clip-path="url(#clipPath3335)">
    <use
       xlink:href="#glyph-2-1"
       x="450.711"
       y="82.306"
       id="use1801" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1807"
     clip-path="url(#clipPath3331)">
    <use
       xlink:href="#glyph-2-2"
       x="453.54616"
       y="113.4822"
       id="use1805" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1811"
     clip-path="url(#clipPath3327)">
    <use
       xlink:href="#glyph-4-2"
       x="411.02116"
       y="150.3373"
       id="use1809" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1815"
     clip-path="url(#clipPath3323)">
    <use
       xlink:href="#glyph-3-2"
       x="421.42506"
       y="150.3373"
       id="use1813" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1819"
     clip-path="url(#clipPath3319)">
    <use
       xlink:href="#glyph-4-3"
       x="433.85396"
       y="150.3373"
       id="use1817" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1823"
     clip-path="url(#clipPath3315)">
    <use
       xlink:href="#glyph-4-1"
       x="445.211735"
       y="150.3373"
       id="use1821" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1827"
     clip-path="url(#clipPath3311)">
    <use
       xlink:href="#glyph-3-3"
       x="453.34766"
       y="150.3373"
       id="use1825" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1831"
     clip-path="url(#clipPath3307)">
    <use
       xlink:href="#glyph-4-4"
       x="465.11056"
       y="150.3373"
       id="use1829" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1835"
     clip-path="url(#clipPath3303)">
    <use
       xlink:href="#glyph-3-1"
       x="475.38866"
       y="150.3373"
       id="use1833" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1839"
     clip-path="url(#clipPath3299)">
    <use
       xlink:href="#glyph-4-1"
       x="473.30077"
       y="150.3373"
       id="use1837" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1843"
     clip-path="url(#clipPath3295)">
    <use
       xlink:href="#glyph-5-1"
       x="501.73167"
       y="150.3373"
       id="use1841" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1847"
     clip-path="url(#clipPath3291)">
    <use
       xlink:href="#glyph-5-2"
       x="506.289346"
       y="150.3373"
       id="use1845" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1851"
     clip-path="url(#clipPath3287)">
    <use
       xlink:href="#glyph-5-3"
       x="512.133828"
       y="150.3373"
       id="use1849" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1855"
     clip-path="url(#clipPath3283)">
    <use
       xlink:href="#glyph-5-23"
       x="515.383711"
       y="150.3373"
       id="use1853" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1859"
     clip-path="url(#clipPath3279)">
    <use
       xlink:href="#glyph-5-5"
       x="521.228192"
       y="150.3373"
       id="use1857" />
  </g>
  <g
     clip-path="url(#clipPath3275)"
     id="g1865">
    <g
       clip-path="url(#clip-45)"
       id="g1863">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4317.773438 5681.835938 L 5253.164062 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1861" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 516.75 275.707031 L 524.308594 273.816406 L 516.75 271.925781 Z M 516.75 275.707031 "
     id="path1867"
     clip-path="url(#clipPath3271)" />
  <g
     clip-path="url(#clipPath3267)"
     id="g1871">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 5167.5 5662.929688 L 5243.085938 5681.835938 L 5167.5 5700.742188 Z M 5167.5 5662.929688 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1869" />
  </g>
  <g
     clip-path="url(#clipPath3263)"
     id="g1877">
    <g
       clip-path="url(#clip-48)"
       id="g1875">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4402.773438 6532.1875 L 4402.773438 5681.835938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1873" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 442.167969 197.347656 L 440.277344 189.789062 L 438.390625 197.347656 Z M 442.167969 197.347656 "
     id="path1879"
     clip-path="url(#clipPath3259)" />
  <g
     clip-path="url(#clipPath3255)"
     id="g1883">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 4421.679688 6446.523438 L 4402.773438 6522.109375 L 4383.90625 6446.523438 Z M 4421.679688 6446.523438 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1881" />
  </g>
  <path
     fill="none"
     stroke-width="4.72425"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4374.453125 6248.75 L 4431.132812 6248.75 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1885"
     clip-path="url(#clipPath3251)" />
  <path
     fill="none"
     stroke-width="4.72425"
     stroke-linecap="round"
     stroke-linejoin="round"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-dasharray="37.794"
     stroke-miterlimit="10"
     d="M 4402.773438 6248.75 L 5168.125 6248.75 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1887"
     clip-path="url(#clipPath3247)" />
  <path
     fill="none"
     stroke-width="18.897"
     stroke-linecap="round"
     stroke-linejoin="bevel"
     stroke="rgb(82.03125%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4402.773438 5681.835938 L 4402.773438 5682.460938 L 4403.4375 5684.960938 L 4404.6875 5690.664062 L 4406.5625 5700.117188 L 4409.101562 5712.695312 L 4412.226562 5727.1875 L 4415.390625 5741.679688 L 4417.890625 5756.171875 L 4420.429688 5768.75 L 4422.96875 5779.453125 L 4425.46875 5789.53125 L 4427.34375 5798.359375 L 4429.257812 5806.5625 L 4431.132812 5814.101562 L 4433.046875 5822.929688 L 4435.546875 5831.132812 L 4438.085938 5839.296875 L 4440.585938 5848.125 L 4443.125 5856.953125 L 4446.25 5865.117188 L 4448.789062 5873.945312 L 4451.914062 5882.148438 L 4455.078125 5890.3125 L 4458.203125 5897.890625 L 4460.742188 5906.09375 L 4464.53125 5913.007812 L 4467.65625 5921.210938 L 4471.445312 5929.375 L 4475.234375 5937.578125 L 4479.648438 5946.40625 L 4484.0625 5955.859375 L 4489.101562 5965.273438 L 4494.140625 5974.726562 L 4499.804688 5984.179688 L 4504.84375 5993.007812 L 4510.507812 6001.171875 L 4515.546875 6009.375 L 4521.210938 6016.953125 L 4525.625 6023.867188 L 4530.664062 6030.15625 L 4535.703125 6036.484375 L 4541.367188 6043.398438 L 4547.65625 6050.3125 L 4553.984375 6057.265625 L 4560.898438 6063.554688 L 4574.765625 6077.421875 L 4581.679688 6083.710938 L 4589.257812 6090 L 4596.171875 6095.664062 L 4603.085938 6101.367188 L 4610.664062 6107.03125 L 4618.203125 6112.695312 L 4634.609375 6124.023438 L 4643.398438 6130.3125 L 4653.476562 6135.976562 L 4662.929688 6142.304688 L 4673.632812 6147.96875 L 4683.710938 6154.257812 L 4694.453125 6159.921875 L 4714.609375 6170 L 4724.023438 6174.414062 L 4733.476562 6178.828125 L 4742.929688 6182.617188 L 4752.382812 6186.367188 L 4771.289062 6192.695312 L 4781.992188 6195.820312 L 4792.070312 6198.984375 L 4802.773438 6202.148438 L 4814.101562 6204.648438 L 4824.84375 6207.1875 L 4835.546875 6209.0625 L 4845.625 6211.5625 L 4856.328125 6213.476562 L 4865.78125 6214.726562 L 4875.234375 6216.601562 L 4884.6875 6217.890625 L 4894.101562 6219.140625 L 4903.554688 6220.390625 L 4913.632812 6221.640625 L 4923.710938 6222.929688 L 4934.414062 6224.179688 L 4945.15625 6225.429688 L 4955.859375 6226.71875 L 4966.5625 6227.34375 L 4977.890625 6228.59375 L 4987.96875 6229.21875 L 4998.671875 6229.84375 L 5008.125 6231.09375 L 5017.578125 6231.757812 L 5027.03125 6231.757812 L 5036.484375 6232.382812 L 5056.640625 6233.632812 L 5067.34375 6234.257812 L 5079.921875 6234.257812 L 5093.164062 6234.882812 L 5123.398438 6236.132812 L 5138.515625 6236.132812 L 5151.757812 6236.796875 L 5161.835938 6237.421875 L 5170.625 6237.421875 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1889"
     clip-path="url(#clipPath3243)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1893"
     clip-path="url(#clipPath3239)">
    <use
       xlink:href="#glyph-4-1"
       x="426.141"
       y="197.326"
       id="use1891" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1897"
     clip-path="url(#clipPath3235)">
    <use
       xlink:href="#glyph-4-5"
       x="516.8609"
       y="288.0373"
       id="use1895" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1901"
     clip-path="url(#clipPath3231)">
    <use
       xlink:href="#glyph-4-1"
       x="420.471"
       y="219.997"
       id="use1899" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1905"
     clip-path="url(#clipPath3227)">
    <use
       xlink:href="#glyph-8-1"
       x="425.95186"
       y="221.78802"
       id="use1903" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1909"
     clip-path="url(#clipPath3223)">
    <use
       xlink:href="#glyph-4-1"
       x="411.02096"
       y="306.24422"
       id="use1907" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1913"
     clip-path="url(#clipPath3219)">
    <use
       xlink:href="#glyph-3-4"
       x="416.50182"
       y="306.24422"
       id="use1911" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1917"
     clip-path="url(#clipPath3215)">
    <use
       xlink:href="#glyph-3-5"
       x="421.055793"
       y="306.24422"
       id="use1915" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1921"
     clip-path="url(#clipPath3211)">
    <use
       xlink:href="#glyph-3-6"
       x="426.905792"
       y="306.24422"
       id="use1919" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1925"
     clip-path="url(#clipPath3207)">
    <use
       xlink:href="#glyph-3-2"
       x="434.780652"
       y="306.24422"
       id="use1923" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1929"
     clip-path="url(#clipPath3203)">
    <use
       xlink:href="#glyph-3-5"
       x="447.200543"
       y="306.24422"
       id="use1927" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1933"
     clip-path="url(#clipPath3199)">
    <use
       xlink:href="#glyph-4-1"
       x="411.02096"
       y="328.91492"
       id="use1931" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1937"
     clip-path="url(#clipPath3195)">
    <use
       xlink:href="#glyph-3-4"
       x="416.50182"
       y="328.91492"
       id="use1935" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1941"
     clip-path="url(#clipPath3191)">
    <use
       xlink:href="#glyph-7-1"
       x="421.05573"
       y="328.91492"
       id="use1939" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1945"
     clip-path="url(#clipPath3187)">
    <use
       xlink:href="#glyph-3-6"
       x="433.00773"
       y="328.91492"
       id="use1943" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1949"
     clip-path="url(#clipPath3183)">
    <use
       xlink:href="#glyph-3-2"
       x="440.882686"
       y="328.91492"
       id="use1947" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1953"
     clip-path="url(#clipPath3179)">
    <use
       xlink:href="#glyph-3-7"
       x="456.26403"
       y="320.83289"
       id="use1951" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1957"
     clip-path="url(#clipPath3175)">
    <use
       xlink:href="#glyph-4-2"
       x="455.642936"
       y="320.83289"
       id="use1955" />
  </g>
  <path
     fill="none"
     stroke-width="4.86"
     stroke-linecap="butt"
     stroke-linejoin="miter"
     stroke="rgb(0%, 0%, 0%)"
     stroke-opacity="1"
     stroke-miterlimit="10"
     d="M 4545 5160.742188 L 4638.671875 5160.742188 "
     transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
     id="path1959"
     clip-path="url(#clipPath3171)" />
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g1963"
     clip-path="url(#clipPath3167)">
    <use
       xlink:href="#glyph-4-3"
       x="454.5"
       y="337.123"
       id="use1961" />
  </g>
  <g
     clip-path="url(#clipPath3163)"
     id="g1969">
    <g
       clip-path="url(#clip-51)"
       id="g1967">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4345.9375 4689.726562 L 4345.9375 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1965" />
    </g>
  </g>
  <path
     fill-rule="evenodd"
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     d="M 436.480469 381.59375 L 434.59375 374.035156 L 432.703125 381.59375 Z M 436.480469 381.59375 "
     id="path1971"
     clip-path="url(#clipPath3159)" />
  <g
     clip-path="url(#clipPath3155)"
     id="g1975">
    <path
       fill="none"
       stroke-width="4.72425"
       stroke-linecap="butt"
       stroke-linejoin="miter"
       stroke="rgb(0%, 0%, 0%)"
       stroke-opacity="1"
       stroke-miterlimit="10"
       d="M 4364.804688 4604.0625 L 4345.9375 4679.648438 L 4327.03125 4604.0625 Z M 4364.804688 4604.0625 "
       transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
       id="path1973" />
  </g>
  <g
     clip-path="url(#clipPath3151)"
     id="g1981">
    <g
       clip-path="url(#clip-54)"
       id="g1979">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 5196.289062 3839.335938 L 4260.898438 3839.335938 Z M 5196.289062 3839.335938 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1977" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3147)"
     id="g1987">
    <g
       clip-path="url(#clip-56)"
       id="g1985">
      <path
         fill-rule="evenodd"
         fill="rgb(0%, 0%, 0%)"
         fill-opacity="1"
         d="M 511.0625 459.953125 L 518.621094 458.066406 L 511.0625 456.175781 Z M 511.0625 459.953125 "
         id="path1983" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3143)"
     id="g1993">
    <g
       clip-path="url(#clip-58)"
       id="g1991">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="butt"
         stroke-linejoin="miter"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 5110.625 3820.46875 L 5186.210938 3839.335938 L 5110.625 3858.242188 Z M 5110.625 3820.46875 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1989" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3139)"
     id="g1999">
    <g
       clip-path="url(#clip-60)"
       id="g1997">
      <path
         fill="none"
         stroke-width="4.72425"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(0%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4317.578125 4406.25 L 4374.257812 4406.25 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path1995" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3135)"
     id="g2005">
    <g
       clip-path="url(#clip-62)"
       id="g2003">
      <path
         fill="none"
         stroke-width="18.897"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(82.03125%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4345.9375 4406.25 L 5111.25 4406.25 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path2001" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3131)"
     id="g2011">
    <g
       clip-path="url(#clip-64)"
       id="g2009">
      <path
         fill-rule="evenodd"
         fill="rgb(100%, 100%, 100%)"
         fill-opacity="1"
         d="M 436.859375 401.375 C 436.859375 402.625 435.84375 403.640625 434.59375 403.640625 C 433.339844 403.640625 432.324219 402.625 432.324219 401.375 C 432.324219 400.121094 433.339844 399.105469 434.59375 399.105469 C 435.84375 399.105469 436.859375 400.121094 436.859375 401.375 "
         id="path2007" />
    </g>
  </g>
  <g
     clip-path="url(#clipPath3127)"
     id="g2017">
    <g
       clip-path="url(#clip-66)"
       id="g2015">
      <path
         fill="none"
         stroke-width="9.4485"
         stroke-linecap="round"
         stroke-linejoin="round"
         stroke="rgb(82.03125%, 0%, 0%)"
         stroke-opacity="1"
         stroke-miterlimit="10"
         d="M 4368.59375 4406.25 C 4368.59375 4393.75 4358.4375 4383.59375 4345.9375 4383.59375 C 4333.398438 4383.59375 4323.242188 4393.75 4323.242188 4406.25 C 4323.242188 4418.789062 4333.398438 4428.945312 4345.9375 4428.945312 C 4358.4375 4428.945312 4368.59375 4418.789062 4368.59375 4406.25 Z M 4368.59375 4406.25 "
         transform="matrix(0.1, 0, 0, -0.1, 0, 842)"
         id="path2013" />
    </g>
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2021"
     clip-path="url(#clipPath3123)">
    <use
       xlink:href="#glyph-4-2"
       x="420.471"
       y="381.574"
       id="use2019" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2025"
     clip-path="url(#clipPath3119)">
    <use
       xlink:href="#glyph-4-5"
       x="511.1909"
       y="472.2853"
       id="use2023" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2029"
     clip-path="url(#clipPath3115)">
    <use
       xlink:href="#glyph-4-3"
       x="411.9659"
       y="404.254"
       id="use2027" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2033"
     clip-path="url(#clipPath3111)">
    <use
       xlink:href="#glyph-3-7"
       x="424.1159"
       y="404.254"
       id="use2031" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2037"
     clip-path="url(#clipPath3107)">
    <use
       xlink:href="#glyph-4-1"
       x="423.323712"
       y="404.254"
       id="use2035" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2041"
     clip-path="url(#clipPath3103)">
    <use
       xlink:href="#glyph-4-2"
       x="411.021"
       y="490.492"
       id="use2039" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2045"
     clip-path="url(#clipPath3099)">
    <use
       xlink:href="#glyph-3-4"
       x="418.10381"
       y="490.492"
       id="use2043" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2049"
     clip-path="url(#clipPath3095)">
    <use
       xlink:href="#glyph-3-5"
       x="422.657783"
       y="490.492"
       id="use2047" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2053"
     clip-path="url(#clipPath3091)">
    <use
       xlink:href="#glyph-3-6"
       x="428.507782"
       y="490.492"
       id="use2051" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2057"
     clip-path="url(#clipPath3087)">
    <use
       xlink:href="#glyph-7-2"
       x="436.38271"
       y="490.492"
       id="use2055" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2061"
     clip-path="url(#clipPath3083)">
    <use
       xlink:href="#glyph-7-1"
       x="451.655721"
       y="490.492"
       id="use2059" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2065"
     clip-path="url(#clipPath3079)">
    <use
       xlink:href="#glyph-4-2"
       x="411.02101"
       y="513.1721"
       id="use2063" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2069"
     clip-path="url(#clipPath3075)">
    <use
       xlink:href="#glyph-3-4"
       x="418.10382"
       y="513.1721"
       id="use2067" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2073"
     clip-path="url(#clipPath3071)">
    <use
       xlink:href="#glyph-7-1"
       x="422.65773"
       y="513.1721"
       id="use2071" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2077"
     clip-path="url(#clipPath3067)">
    <use
       xlink:href="#glyph-3-6"
       x="434.60973"
       y="513.1721"
       id="use2075" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2081"
     clip-path="url(#clipPath3063)">
    <use
       xlink:href="#glyph-3-2"
       x="442.484686"
       y="513.1721"
       id="use2079" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2085"
     clip-path="url(#clipPath3059)">
    <use
       xlink:href="#glyph-4-3"
       x="454.91363"
       y="513.1721"
       id="use2083" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2089"
     clip-path="url(#clipPath3055)">
    <use
       xlink:href="#glyph-3-7"
       x="467.05463"
       y="513.1721"
       id="use2087" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2093"
     clip-path="url(#clipPath3051)">
    <use
       xlink:href="#glyph-4-1"
       x="466.271817"
       y="513.1721"
       id="use2091" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2097"
     clip-path="url(#clipPath3047)">
    <use
       xlink:href="#glyph-9-1"
       x="85.040817"
       y="532.4951"
       id="use2095" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2101"
     clip-path="url(#clipPath3043)">
    <use
       xlink:href="#glyph-9-2"
       x="92.245496"
       y="532.4951"
       id="use2099" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2105"
     clip-path="url(#clipPath3039)">
    <use
       xlink:href="#glyph-9-3"
       x="95.427875"
       y="532.4951"
       id="use2103" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2111"
     clip-path="url(#clipPath3035)">
    <use
       xlink:href="#glyph-9-4"
       x="101.153281"
       y="532.4951"
       id="use2107" />
    <use
       xlink:href="#glyph-9-5"
       x="107.519408"
       y="532.4951"
       id="use2109" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2115"
     clip-path="url(#clipPath3031)">
    <use
       xlink:href="#glyph-9-6"
       x="112.240393"
       y="532.4951"
       id="use2113" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2119"
     clip-path="url(#clipPath3027)">
    <use
       xlink:href="#glyph-9-7"
       x="121.303805"
       y="532.4951"
       id="use2117" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2123"
     clip-path="url(#clipPath3023)">
    <use
       xlink:href="#glyph-9-8"
       x="127.02921"
       y="532.4951"
       id="use2121" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2127"
     clip-path="url(#clipPath3019)">
    <use
       xlink:href="#glyph-9-9"
       x="130.211589"
       y="532.4951"
       id="use2125" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2131"
     clip-path="url(#clipPath3015)">
    <use
       xlink:href="#glyph-9-10"
       x="135.936994"
       y="532.4951"
       id="use2129" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2135"
     clip-path="url(#clipPath3011)">
    <use
       xlink:href="#glyph-10-1"
       x="142.937717"
       y="532.4951"
       id="use2133" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2139"
     clip-path="url(#clipPath3007)">
    <use
       xlink:href="#glyph-10-2"
       x="149.992121"
       y="532.4951"
       id="use2137" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2143"
     clip-path="url(#clipPath3003)">
    <use
       xlink:href="#glyph-10-3"
       x="154.416815"
       y="532.4951"
       id="use2141" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2147"
     clip-path="url(#clipPath2999)">
    <use
       xlink:href="#glyph-10-4"
       x="159.947654"
       y="532.4951"
       id="use2145" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2151"
     clip-path="url(#clipPath2995)">
    <use
       xlink:href="#glyph-10-5"
       x="164.647089"
       y="532.4951"
       id="use2149" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2155"
     clip-path="url(#clipPath2991)">
    <use
       xlink:href="#glyph-10-6"
       x="169.906594"
       y="532.4951"
       id="use2153" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2159"
     clip-path="url(#clipPath2987)">
    <use
       xlink:href="#glyph-10-7"
       x="172.672497"
       y="532.4951"
       id="use2157" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2163"
     clip-path="url(#clipPath2983)">
    <use
       xlink:href="#glyph-10-8"
       x="177.650741"
       y="532.4951"
       id="use2161" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2167"
     clip-path="url(#clipPath2979)">
    <use
       xlink:href="#glyph-10-7"
       x="184.989889"
       y="532.4951"
       id="use2165" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2171"
     clip-path="url(#clipPath2975)">
    <use
       xlink:href="#glyph-10-9"
       x="189.968133"
       y="532.4951"
       id="use2169" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2175"
     clip-path="url(#clipPath2971)">
    <use
       xlink:href="#glyph-10-10"
       x="196.443371"
       y="532.4951"
       id="use2173" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2179"
     clip-path="url(#clipPath2967)">
    <use
       xlink:href="#glyph-10-3"
       x="200.315432"
       y="532.4951"
       id="use2177" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2183"
     clip-path="url(#clipPath2963)">
    <use
       xlink:href="#glyph-10-2"
       x="205.846284"
       y="532.4951"
       id="use2181" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2187"
     clip-path="url(#clipPath2959)">
    <use
       xlink:href="#glyph-10-11"
       x="213.691106"
       y="532.4951"
       id="use2185" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2191"
     clip-path="url(#clipPath2955)">
    <use
       xlink:href="#glyph-10-4"
       x="222.81271"
       y="532.4951"
       id="use2189" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2195"
     clip-path="url(#clipPath2951)">
    <use
       xlink:href="#glyph-10-12"
       x="227.790953"
       y="532.4951"
       id="use2193" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2199"
     clip-path="url(#clipPath2947)">
    <use
       xlink:href="#glyph-10-13"
       x="233.05047"
       y="532.4951"
       id="use2197" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2203"
     clip-path="url(#clipPath2943)">
    <use
       xlink:href="#glyph-10-2"
       x="239.962125"
       y="532.4951"
       id="use2201" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2207"
     clip-path="url(#clipPath2939)">
    <use
       xlink:href="#glyph-10-14"
       x="244.386831"
       y="532.4951"
       id="use2205" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2211"
     clip-path="url(#clipPath2935)">
    <use
       xlink:href="#glyph-10-14"
       x="247.152734"
       y="532.4951"
       id="use2209" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2215"
     clip-path="url(#clipPath2931)">
    <use
       xlink:href="#glyph-10-4"
       x="253.365825"
       y="532.4951"
       id="use2213" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2219"
     clip-path="url(#clipPath2927)">
    <use
       xlink:href="#glyph-10-15"
       x="258.344068"
       y="532.4951"
       id="use2217" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2223"
     clip-path="url(#clipPath2923)">
    <use
       xlink:href="#glyph-10-16"
       x="263.874896"
       y="532.4951"
       id="use2221" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2227"
     clip-path="url(#clipPath2919)">
    <use
       xlink:href="#glyph-10-10"
       x="272.834926"
       y="532.4951"
       id="use2225" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2231"
     clip-path="url(#clipPath2915)">
    <use
       xlink:href="#glyph-10-3"
       x="276.706975"
       y="532.4951"
       id="use2229" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2235"
     clip-path="url(#clipPath2911)">
    <use
       xlink:href="#glyph-10-2"
       x="282.237827"
       y="532.4951"
       id="use2233" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2239"
     clip-path="url(#clipPath2907)">
    <use
       xlink:href="#glyph-10-17"
       x="290.091635"
       y="532.4951"
       id="use2237" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2243"
     clip-path="url(#clipPath2903)">
    <use
       xlink:href="#glyph-10-2"
       x="297.844766"
       y="532.4951"
       id="use2241" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2247"
     clip-path="url(#clipPath2899)">
    <use
       xlink:href="#glyph-10-14"
       x="302.269472"
       y="532.4951"
       id="use2245" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2251"
     clip-path="url(#clipPath2895)">
    <use
       xlink:href="#glyph-10-5"
       x="305.035375"
       y="532.4951"
       id="use2249" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2255"
     clip-path="url(#clipPath2891)">
    <use
       xlink:href="#glyph-10-6"
       x="310.294893"
       y="532.4951"
       id="use2253" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2259"
     clip-path="url(#clipPath2887)">
    <use
       xlink:href="#glyph-10-15"
       x="313.06082"
       y="532.4951"
       id="use2257" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2263"
     clip-path="url(#clipPath2883)">
    <use
       xlink:href="#glyph-10-18"
       x="318.591648"
       y="532.4951"
       id="use2261" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2267"
     clip-path="url(#clipPath2879)">
    <use
       xlink:href="#glyph-10-19"
       x="323.569891"
       y="532.4951"
       id="use2265" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2271"
     clip-path="url(#clipPath2875)">
    <use
       xlink:href="#glyph-10-7"
       x="330.213771"
       y="532.4951"
       id="use2269" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2275"
     clip-path="url(#clipPath2871)">
    <use
       xlink:href="#glyph-10-6"
       x="335.192015"
       y="532.4951"
       id="use2273" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2279"
     clip-path="url(#clipPath2867)">
    <use
       xlink:href="#glyph-10-20"
       x="337.957918"
       y="532.4951"
       id="use2277" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2283"
     clip-path="url(#clipPath2863)">
    <use
       xlink:href="#glyph-10-10"
       x="342.936161"
       y="532.4951"
       id="use2281" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2287"
     clip-path="url(#clipPath2859)">
    <use
       xlink:href="#glyph-10-21"
       x="350.255205"
       y="532.4951"
       id="use2285" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2291"
     clip-path="url(#clipPath2855)">
    <use
       xlink:href="#glyph-10-7"
       x="358.551911"
       y="532.4951"
       id="use2289" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2295"
     clip-path="url(#clipPath2851)">
    <use
       xlink:href="#glyph-10-16"
       x="363.809061"
       y="532.4951"
       id="use2293" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2299"
     clip-path="url(#clipPath2847)">
    <use
       xlink:href="#glyph-10-2"
       x="369.339913"
       y="532.4951"
       id="use2297" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2303"
     clip-path="url(#clipPath2843)">
    <use
       xlink:href="#glyph-10-14"
       x="373.764595"
       y="532.4951"
       id="use2301" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2307"
     clip-path="url(#clipPath2839)">
    <use
       xlink:href="#glyph-10-4"
       x="379.959603"
       y="532.4951"
       id="use2305" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2311"
     clip-path="url(#clipPath2835)">
    <use
       xlink:href="#glyph-10-10"
       x="384.937847"
       y="532.4951"
       id="use2309" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2315"
     clip-path="url(#clipPath2831)">
    <use
       xlink:href="#glyph-10-22"
       x="392.239068"
       y="532.4951"
       id="use2313" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2319"
     clip-path="url(#clipPath2827)">
    <use
       xlink:href="#glyph-10-8"
       x="397.76992"
       y="532.4951"
       id="use2317" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2323"
     clip-path="url(#clipPath2823)">
    <use
       xlink:href="#glyph-10-2"
       x="401.671197"
       y="532.4951"
       id="use2321" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2327"
     clip-path="url(#clipPath2819)">
    <use
       xlink:href="#glyph-10-23"
       x="406.095903"
       y="532.4951"
       id="use2325" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2331"
     clip-path="url(#clipPath2815)">
    <use
       xlink:href="#glyph-10-24"
       x="410.025432"
       y="532.4951"
       id="use2329" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2335"
     clip-path="url(#clipPath2811)">
    <use
       xlink:href="#glyph-10-8"
       x="414.450113"
       y="532.4951"
       id="use2333" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2339"
     clip-path="url(#clipPath2807)">
    <use
       xlink:href="#glyph-10-6"
       x="418.356717"
       y="532.4951"
       id="use2337" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2343"
     clip-path="url(#clipPath2803)">
    <use
       xlink:href="#glyph-10-25"
       x="421.12262"
       y="532.4951"
       id="use2341" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2347"
     clip-path="url(#clipPath2799)">
    <use
       xlink:href="#glyph-10-2"
       x="426.932354"
       y="532.4951"
       id="use2345" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2351"
     clip-path="url(#clipPath2795)">
    <use
       xlink:href="#glyph-10-16"
       x="431.357036"
       y="532.4951"
       id="use2349" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2355"
     clip-path="url(#clipPath2791)">
    <use
       xlink:href="#glyph-10-24"
       x="440.317066"
       y="532.4951"
       id="use2353" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2359"
     clip-path="url(#clipPath2787)">
    <use
       xlink:href="#glyph-10-7"
       x="444.741748"
       y="532.4951"
       id="use2357" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2363"
     clip-path="url(#clipPath2783)">
    <use
       xlink:href="#glyph-10-15"
       x="449.719991"
       y="532.4951"
       id="use2361" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2367"
     clip-path="url(#clipPath2779)">
    <use
       xlink:href="#glyph-10-23"
       x="455.250819"
       y="532.4951"
       id="use2365" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2371"
     clip-path="url(#clipPath2775)">
    <use
       xlink:href="#glyph-10-10"
       x="459.180347"
       y="532.4951"
       id="use2369" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2375"
     clip-path="url(#clipPath2771)">
    <use
       xlink:href="#glyph-10-4"
       x="463.052445"
       y="532.4951"
       id="use2373" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2379"
     clip-path="url(#clipPath2767)">
    <use
       xlink:href="#glyph-10-15"
       x="468.030689"
       y="532.4951"
       id="use2377" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2383"
     clip-path="url(#clipPath2763)">
    <use
       xlink:href="#glyph-10-10"
       x="473.282659"
       y="532.4951"
       id="use2381" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2387"
     clip-path="url(#clipPath2759)">
    <use
       xlink:href="#glyph-10-23"
       x="480.583571"
       y="532.4951"
       id="use2385" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2391"
     clip-path="url(#clipPath2755)">
    <use
       xlink:href="#glyph-10-10"
       x="484.513099"
       y="532.4951"
       id="use2389" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2395"
     clip-path="url(#clipPath2751)">
    <use
       xlink:href="#glyph-10-8"
       x="488.385148"
       y="532.4951"
       id="use2393" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2399"
     clip-path="url(#clipPath2747)">
    <use
       xlink:href="#glyph-10-2"
       x="492.28645"
       y="532.4951"
       id="use2397" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2403"
     clip-path="url(#clipPath2743)">
    <use
       xlink:href="#glyph-10-23"
       x="496.711132"
       y="532.4951"
       id="use2401" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2407"
     clip-path="url(#clipPath2739)">
    <use
       xlink:href="#glyph-10-23"
       x="500.64066"
       y="532.4951"
       id="use2405" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2411"
     clip-path="url(#clipPath2735)">
    <use
       xlink:href="#glyph-10-7"
       x="507.990259"
       y="532.4951"
       id="use2409" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2415"
     clip-path="url(#clipPath2731)">
    <use
       xlink:href="#glyph-10-8"
       x="512.968503"
       y="532.4951"
       id="use2413" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2419"
     clip-path="url(#clipPath2727)">
    <use
       xlink:href="#glyph-10-24"
       x="520.30789"
       y="532.4951"
       id="use2417" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2423"
     clip-path="url(#clipPath2723)">
    <use
       xlink:href="#glyph-10-7"
       x="524.732571"
       y="532.4951"
       id="use2421" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2427"
     clip-path="url(#clipPath2719)">
    <use
       xlink:href="#glyph-10-15"
       x="529.710815"
       y="532.4951"
       id="use2425" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2431"
     clip-path="url(#clipPath2715)">
    <use
       xlink:href="#glyph-10-26"
       x="535.241643"
       y="532.4951"
       id="use2429" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2435"
     clip-path="url(#clipPath2711)">
    <use
       xlink:href="#glyph-10-23"
       x="85.040717"
       y="544.456"
       id="use2433" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2439"
     clip-path="url(#clipPath2707)">
    <use
       xlink:href="#glyph-10-10"
       x="88.970257"
       y="544.456"
       id="use2437" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2443"
     clip-path="url(#clipPath2703)">
    <use
       xlink:href="#glyph-10-4"
       x="92.842313"
       y="544.456"
       id="use2441" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2447"
     clip-path="url(#clipPath2699)">
    <use
       xlink:href="#glyph-10-15"
       x="97.820562"
       y="544.456"
       id="use2445" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2451"
     clip-path="url(#clipPath2695)">
    <use
       xlink:href="#glyph-10-10"
       x="103.072337"
       y="544.456"
       id="use2449" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2455"
     clip-path="url(#clipPath2691)">
    <use
       xlink:href="#glyph-10-23"
       x="110.265423"
       y="544.456"
       id="use2453" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2459"
     clip-path="url(#clipPath2687)">
    <use
       xlink:href="#glyph-10-10"
       x="114.194951"
       y="544.456"
       id="use2457" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2463"
     clip-path="url(#clipPath2683)">
    <use
       xlink:href="#glyph-10-8"
       x="118.067025"
       y="544.456"
       id="use2461" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2467"
     clip-path="url(#clipPath2679)">
    <use
       xlink:href="#glyph-10-4"
       x="121.968302"
       y="544.456"
       id="use2465" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2471"
     clip-path="url(#clipPath2675)">
    <use
       xlink:href="#glyph-10-6"
       x="126.946546"
       y="544.456"
       id="use2469" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2475"
     clip-path="url(#clipPath2671)">
    <use
       xlink:href="#glyph-10-15"
       x="129.712461"
       y="544.456"
       id="use2473" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2479"
     clip-path="url(#clipPath2667)">
    <use
       xlink:href="#glyph-10-27"
       x="135.243301"
       y="544.456"
       id="use2477" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2483"
     clip-path="url(#clipPath2663)">
    <use
       xlink:href="#glyph-5-24"
       x="304.010717"
       y="793.801"
       id="use2481" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2487"
     clip-path="url(#clipPath2659)">
    <use
       xlink:href="#glyph-5-25"
       x="309.855174"
       y="793.801"
       id="use2485" />
  </g>
  <g
     fill="rgb(0%, 0%, 0%)"
     fill-opacity="1"
     id="g2491"
     clip-path="url(#clipPath2655)">
    <use
       xlink:href="#glyph-5-2"
       x="313.748459"
       y="793.801"
       id="use2489" />
  </g>
</svg>
""";

# ╔═╡ 1e07342e-22b1-437e-8398-ef97c276a1df
HTML(theorie2)

# ╔═╡ 76508c42-b1ce-44a2-b6e9-0b83ccb375e4
md"""
## Part 2 – 3 Parameter Models
Neither the Maxwell nor the Kelvin-Voigt model alone can realistically represent creep or relaxation of a viscoelastic solid. Thus, we are going to look at a combination of two Hooke-Elements with one Newton-Element which is often called the 3 Parameter-Model, the viscoelastic standard model or the Zener-Model

Below you can see

a) The 'Zener K' model: Kelvin-Voigt with a Hooke element in series

b) The 'Zener M' model: Maxwell with a Hooke element in parallel

For both models we are going to derive and then implement the governing equations.
"""

# ╔═╡ df4d49d3-6262-4156-a43e-346453ac19a3
_3params = """<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   id="svg1749"
   xml:space="preserve"
   width="100%"
   height="200"
   viewBox="0 0 576.86975 114.69975"
   sodipodi:docname="3params.svg"
   inkscape:version="1.0.2 (e86c870879, 2021-01-15)"><metadata
     id="metadata1755"><rdf:RDF><cc:Work
         rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
     id="defs1753"><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1799"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z"
         id="path1797" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1805"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z m 1920.82,-444.31 h 80 v 30.24 h -80 v 0 l 60.47,-15.11 z"
         clip-rule="evenodd"
         id="path1803" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1815"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z"
         id="path1813" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1827"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z"
         id="path1825" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1833"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z m 77.73,-414.07 h -80 v -30.24 h 80 v 0 l -60.47,15.13 z"
         clip-rule="evenodd"
         id="path1831" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1843"><path
         d="m 1134,7012.2 v -830 h 2000 v 830 z"
         id="path1841" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1911"><path
         d="m 3402,7052.2 v -870 h 1790 v 870 z m 1707.91,-449.31 h 80 v 30.24 h -80 v 0 l 60.47,-15.12 z"
         clip-rule="evenodd"
         id="path1909" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1921"><path
         d="m 3402,7052.2 v -870 h 1790 v 870 z"
         id="path1919" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1933"><path
         d="m 3402,7052.2 v -870 h 1790 v 870 z"
         id="path1931" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1939"><path
         d="m 3402,7052.2 v -870 h 1790 v 870 z m 77.73,-419.07 h -80 v -30.24 h 80 v 0 l -60.47,15.12 z"
         clip-rule="evenodd"
         id="path1937" /></clipPath><clipPath
       clipPathUnits="userSpaceOnUse"
       id="clipPath1949"><path
         d="m 3402,7052.2 v -870 h 1790 v 870 z"
         id="path1947" /></clipPath></defs><sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1900"
     inkscape:window-height="1033"
     id="namedview1751"
     showgrid="false"
     inkscape:zoom="1.4319991"
     inkscape:cx="319.80992"
     inkscape:cy="36.367687"
     inkscape:window-x="1929"
     inkscape:window-y="36"
     inkscape:window-maximized="0"
     inkscape:current-layer="g2003" /><g
     id="g1757"
     inkscape:groupmode="layer"
     inkscape:label="L01_materialmodellierung_2018"
     transform="matrix(1.3333333,0,0,-1.3333333,-114.17321,936.47439)"><g
       id="g1759"
       transform="scale(0.1)"><g
         id="g1793"><g
           id="g1795"
           clip-path="url(#clipPath1799)"><g
             id="g1801"
             clip-path="url(#clipPath1805)"><path
               d="m 2912.46,6583.02 h 212.91"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path1807" /></g></g></g><g
         id="g1809"><g
           id="g1811"
           clip-path="url(#clipPath1815)"><path
             d="m 3054.82,6567.89 60.47,15.13 -60.47,15.11 v -30.24"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path1817" /><path
             d="m 3054.82,6567.89 60.47,15.13 -60.47,15.11 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1819" /></g></g><g
         id="g1821"><g
           id="g1823"
           clip-path="url(#clipPath1827)"><g
             id="g1829"
             clip-path="url(#clipPath1833)"><path
               d="M 1353.46,6583.02 H 1141.18"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path1835" /></g></g></g><g
         id="g1837"><g
           id="g1839"
           clip-path="url(#clipPath1843)"><path
             d="m 1211.73,6598.13 -60.47,-15.11 60.47,-15.13 v 30.24"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path1845" /><path
             d="m 1211.73,6598.13 -60.47,-15.11 60.47,-15.13 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1847" /><path
             d="m 2203.82,6583.02 h 141.73 l 17.64,71.17 35.27,-141.73 35.28,141.73 35.27,-141.73 35.91,141.73 35.27,-141.73 35.27,141.73 35.28,-141.73 35.9,141.73 35.28,-141.73 17.63,70.56 h 141.73"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1849" /><path
             d="m 1566.36,6760.02 h 141.73 l 17.64,71.18 35.27,-141.73 35.28,141.73 35.27,-141.73 35.91,141.73 35.27,-141.73 35.28,141.73 35.27,-141.73 35.9,141.73 35.28,-141.73 17.64,70.55 h 141.72"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1851" /><path
             d="M 2203.82,6760.02 V 6406.01"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1853" /><path
             d="m 1566.36,6406.01 v 354.01"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1855" /><path
             d="M 1566.36,6583.02 H 1424.64"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1857" /><path
             d="M 1920.37,6406.01 H 1566.36"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1859" /><path
             d="m 1778.64,6335.46 h 248.18 v 141.73 h -248.18"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1861" /><path
             d="m 2026.82,6406.01 h 177"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1863" /><path
             d="M 1920.37,6463.33 V 6349.32"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1865" /></g></g><g
         id="g1867"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,298.44,661.9)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1871"><tspan
             x="0"
             y="0"
             id="tspan1869">σ</tspan></text></g><g
         id="g1873"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,125.52,661.9)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1879"><tspan
             x="0"
             y="0"
             id="tspan1875">σ</tspan><tspan
             x="119.76"
             y="-10.6801"
             id="tspan1877">E</tspan></text><text
           transform="matrix(1,0,0,-1,253.91984,670.7801)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1883"><tspan
             x="0"
             y="0"
             id="tspan1881">H</tspan></text><text
           transform="matrix(1,0,0,-1,181.43974,690.2199)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1887"><tspan
             x="0"
             y="0"
             id="tspan1885">E</tspan></text><text
           transform="matrix(1,0,0,-1,190.07997,688.4199)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1891"><tspan
             x="0"
             y="0"
             id="tspan1889">K</tspan></text><text
           transform="matrix(1,0,0,-1,184.91981,622.9)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1895"><tspan
             x="0"
             y="0"
             id="tspan1893">η</tspan></text><text
           transform="matrix(1,0,0,-1,190.67997,621.1)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1899"><tspan
             x="0"
             y="0"
             id="tspan1897">K</tspan></text><text
           transform="matrix(1,0,0,-1,85.07997,618.21992)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:SFRM1200;-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1903"><tspan
             x="0 5.8745046"
             y="0"
             sodipodi:role="line"
             id="tspan1901">a)</tspan></text></g><g
         id="g1905"><g
           id="g1907"
           clip-path="url(#clipPath1911)"><path
             d="m 4968.19,6618.01 h 212.27"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1913" /></g></g><g
         id="g1915"><g
           id="g1917"
           clip-path="url(#clipPath1921)"><path
             d="m 5109.91,6602.89 60.47,15.12 -60.47,15.12 v -30.24"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path1923" /><path
             d="m 5109.91,6602.89 60.47,15.12 -60.47,15.12 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1925" /></g></g><g
         id="g1927"><g
           id="g1929"
           clip-path="url(#clipPath1933)"><g
             id="g1935"
             clip-path="url(#clipPath1939)"><path
               d="M 3621.46,6618.01 H 3409.18"
               style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
               id="path1941" /></g></g></g><g
         id="g1943"><g
           id="g1945"
           clip-path="url(#clipPath1949)"><path
             d="m 3479.73,6633.13 -60.47,-15.12 60.47,-15.12 v 30.24"
             style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none"
             id="path1951" /><path
             d="m 3479.73,6633.13 -60.47,-15.12 60.47,-15.12 z"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1953" /><path
             d="M 4897.01,6618.01 H 4755.28"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1955" /><path
             d="M 4755.28,6795.02 V 6441.01"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1957" /><path
             d="m 3834.37,6795.02 h 283.45 l 17.64,71.17 35.27,-141.73 35.28,141.73 35.27,-141.73 35.9,141.73 35.28,-141.73 35.27,141.73 35.28,-141.73 35.9,141.73 35.28,-141.73 17.63,70.56 h 283.46"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1959" /><path
             d="m 3834.37,6441.01 v 354.01"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1961" /><path
             d="M 3834.37,6618.01 H 3692.64"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1963" /><path
             d="m 3834.37,6441.01 h 70.54 l 17.64,71.18 35.27,-141.73 35.28,141.73 35.28,-141.73 35.9,141.73 35.27,-141.73 35.28,141.73 35.27,-141.73 35.91,141.73 35.27,-141.73 17.64,70.55 h 141.72"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1965" /><path
             d="M 4578.28,6496.44 V 6385.58"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1967" /><path
             d="m 4684.73,6441.01 h 70.55"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1969" /><path
             d="m 4436.55,6370.46 h 248.18 v 141.73 h -248.18"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1971" /><path
             d="m 4578.28,6441.01 h -177"
             style="fill:none;stroke:#000000;stroke-width:4.72425;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;stroke-dasharray:none;stroke-opacity:1"
             id="path1973" /></g></g><g
         id="g1975"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,502.44,665.38)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1981"><tspan
             x="0 -150.24001"
             y="0"
             sodipodi:role="line"
             id="tspan1977">σσ</tspan><tspan
             x="-80.040001"
             y="-28.4398"
             id="tspan1979">E</tspan></text><text
           transform="matrix(1,0,0,-1,431.03984,692.0198)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1985"><tspan
             x="0"
             y="0"
             id="tspan1983">H</tspan></text><text
           transform="matrix(1,0,0,-1,400.43984,622.8999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1989"><tspan
             x="0"
             y="0"
             id="tspan1987">E</tspan></text><text
           transform="matrix(1,0,0,-1,409.08007,621.0999)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1993"><tspan
             x="0"
             y="0"
             id="tspan1991">M</tspan></text><text
           transform="matrix(1,0,0,-1,451.43987,622.8999)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:CMMI12;-inkscape-font-specification:CMMI12;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text1997"><tspan
             x="0"
             y="0"
             id="tspan1995">η</tspan></text><text
           transform="matrix(1,0,0,-1,457.20003,621.0999)"
           style="font-variant:normal;font-weight:normal;font-size:7.97011px;font-family:SFRM0800;-inkscape-font-specification:SFRM0800;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text2001"><tspan
             x="0"
             y="0"
             id="tspan1999">M</tspan></text></g><g
         id="g2003"
         transform="scale(10)"><text
           transform="matrix(1,0,0,-1,311.76,618.22)"
           style="font-variant:normal;font-weight:normal;font-size:11.9552px;font-family:SFRM1200;-inkscape-font-specification:SFRM1200;writing-mode:lr-tb;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="text2007"><tspan
             x="0 6.4818516"
             y="0"
             sodipodi:role="line"
             id="tspan2005">b)</tspan></text></g></g></g></svg>
""";

# ╔═╡ 9e6f7e42-d8cd-4c18-816b-c31a2fe5ccb0
HTML(_3params)

# ╔═╡ 2a21d8e8-4af9-40ed-9f15-24d0501ca00a
md"""
### Zener K Modell
"""

# ╔═╡ 2f775b07-32d8-482a-ba9a-841f57c81765
Eₖ = 20; Eₕ = 20; ηₖ = 5; εₖ = 0.012; ε̇ₖ = 0.006;

# ╔═╡ 3436bf12-bfd6-4d97-aa22-9c6725a11bf4
md"""
Define `σₖ` using to the variables defined above
"""

# ╔═╡ 19e97301-904f-43d6-85f4-7dd70d48357c
σₖ = missing

# ╔═╡ 8a4bf004-ef75-4eb3-8f87-5ebb70f6eb03
md"""
How are the stresses $\sigma$, $\sigma_{k}$ and $\sigma_{h}$ related?
"""

# ╔═╡ e7b1666c-cbd1-493c-98f6-3345e5e617fa
σ = missing

# ╔═╡ 636ce699-1d4d-4368-8372-104258c52c8f
md"""
Now define $\varepsilon_{h}$ and the total strain $\varepsilon$ in terms of $\varepsilon_{h}$
"""

# ╔═╡ 7cd868d6-9b1d-42df-9246-226ace25abe5
εₕ = missing

# ╔═╡ f1174e63-6c27-43e9-bcc2-502177183374
ε = missing

# ╔═╡ f0d058b5-86fa-4d1c-81db-f89a9512cda9
md"""
Now let us derive the ordinary differential equation that describes the Zener K model

Starting with following relationships

```math
\sigma_K = E_K \varepsilon_K+\eta_K \dot{\varepsilon}_K
```
"""

# ╔═╡ ca06cb3b-10dd-4ff7-a625-e2eeb665a707
md"""

```math
\varepsilon = \varepsilon_K + \varepsilon_H \quad \rightarrow \quad \varepsilon_K = \varepsilon - \varepsilon_H
```
"""

# ╔═╡ 2195e334-afda-49f4-8bb5-ccf4d1740d3d
md"""
by inserting $\varepsilon_K$ in $\sigma_K = \sigma$ we get
```math
     \sigma = E_K\left(\varepsilon - \frac{\sigma}{E_H}\right) + \eta_K\left(\dot{\varepsilon}-\frac{\dot{\sigma}}{E_H}\right).
```
"""

# ╔═╡ d0579c0c-0147-48d8-860e-3b0f8db77547
md"""
We can reshape the equation into its final form

!!! note "Differential equation"
    ```math
    \dot{\sigma} +\frac{E_H+E_K}{\eta_K} \sigma = E_H \dot{\varepsilon} + \frac{E_H E_K}{\eta_K}\varepsilon
    ```
"""

# ╔═╡ c11144ac-50c4-499e-8456-25f1f0be0303
md"""
Now let's look at the initial and final conditions for our system.
In the end we expect to get $\dot{\sigma} = \dot{\varepsilon} = 0$ because our strains are constant $\varepsilon = \tilde{\varepsilon}$ at $t \to \infty$.
The damper blocks all strain of the K element in the beginning. 
The initial condition is then $\varepsilon_{k}\left(t=0\right) = 0$.

!!! note "Final- and Initial conditions for supplied strains"
    ```math
     \sigma(0)=E_H\tilde{\varepsilon} \qquad \sigma(\infty)=\dfrac{E_H E_K}{E_H + E_K} \tilde{\varepsilon}
    ```
"""

# ╔═╡ 6b46d1e3-7c55-4b8b-830e-d8ac0dcde19f
md"""
In the case of prescribed stress, the conditions are obtained for strains

!!! note "Final- and Initial conditions for prescribed stress"
    ```math
    \varepsilon(0) = \frac{\tilde{\sigma}}{E_H} \qquad \varepsilon(\infty)=\frac{E_H+E_K}{E_H E_K}\tilde{\sigma}
    ```
"""

# ╔═╡ d25dc6d2-8c6c-4893-ba89-79537057f0af
md"""
Since we solve the problem numerically, we need to discretize the problem in terms of time. 
Here, we use the backward or implicit Euler time integration, where all quantities take the values of the current time step $\varepsilon = \varepsilon_{n+1} = \varepsilon(t_{n+1})$ and the finite difference scheme is used for the time derivatives 

```math
	\dot{\varepsilon} = \dfrac{\varepsilon_{n+1} - \varepsilon_{n}}{\Delta t}.
```
"""

# ╔═╡ d27d7600-6f4f-4dc6-a955-2aacfb0cc59b
md"""
The discretized form of the differential equation takes the form

```math
    \frac{\sigma_{n+1}-\sigma_n}{\Delta t} + \frac{E_\text{H}+E_\text{K}}{\eta_\text{K}}\,\sigma_{n+1} = E_\text{H}\,\frac{\varepsilon_{n+1}-\varepsilon_n}{\Delta t}+\frac{E_\text{H}E_\text{K}}{\eta_\text{K}}\,\varepsilon_{n+1},
```
"""

# ╔═╡ 0594e6ed-990d-4417-a432-ea6e9aadcc1e
md"""
which upon reformulating, we obtain

!!! note "Iteration scheme of the Differential equation"
	```math
     \begin{align}
     \sigma_{n+1} &= \frac{\eta_\text{K}\,\sigma_n + E_\text{H}\,\eta_\text{K}\left(\varepsilon_{n+1}-\varepsilon_n\right) + E_\text{H}\,E_\text{K}\Delta t\,\varepsilon_{n+1}}{\eta_\text{K}+\left(E_\text{H}+E_\text{K}\right)\Delta t} ,\\
     \varepsilon_{n+1} &= \frac{E_\text{H}\,\eta_\text{K}\,\varepsilon_n + \eta_\text{K} \left(\sigma_{n+1}-\sigma_n\right) + \left(E_\text{H}+E_\text{K}\right)\Delta t\,\sigma_{n+1}} {E_\text{H}\left(\eta_\text{K}+E_\text{K}\,\Delta t\right)}.
    \end{align}
	```
"""

# ╔═╡ 9f9f662b-6a87-4c49-8db7-aadbc02dc2a7
md"""
### Task 1 – Implementing the Zener K Model
"""

# ╔═╡ c25ad9bc-df5b-448e-8579-5b99ef08fb4e
md"""
We load our system for a duration of 1.5 time units with an amplitude of 0.01 (stress and strain equivalently). This is used for all of the following numerical tests.
"""

# ╔═╡ 6170206d-aee4-4796-972b-543062d62100
md"""
This is a function that associates a constant load to a given vector of timesteps
"""

# ╔═╡ 778ebc7c-153f-4a1d-b285-57149b5750be
function constant(max::Float64, t::Array)
    load = max * ones(length(t))
    return load
end;

# ╔═╡ 7ac4ecf9-2530-44e7-b935-cbf4722b7b60
begin
	time = 0:0.01:1.5
	load = constant(0.01,collect(time))
end;

# ╔═╡ 9b9d21ae-2e18-4f1f-bdcd-ba99c444bb49
md"""
#### Implement the creep test
"""

# ╔═╡ 72c830df-968c-4c7b-b81a-b78eb8531673
function zenerₖ_ε(Eₖ::Float64, Eₕ::Float64, ηₖ::Float64, σ::Array, t)
    ε = zeros(length(t))
    Δσ = zeros(length(t))
    ε[1] = σ[1] / Eₕ # Initial condition

    for n in 1:length(t)-1
		εₙ = ε[n]
		σₙ = σ[n]
		σₙ₊₁ = σ[n+1]
		Δt = t[n+1] - t[n]

        ε[n+1] = (Eₕ*ηₖ*εₙ + ηₖ*(σₙ₊₁-σₙ) + (Eₕ+Eₖ)*Δt*σₙ₊₁)/(Eₕ*(ηₖ+Eₖ*Δt))
    end
    return ε, Δσ
end;

# ╔═╡ f2144560-5d73-4d5c-9e86-a43b1bd95cd8
md"""
#### Implement the relaxation test
"""

# ╔═╡ 69aa89fe-4d6f-4da1-975e-277d74fb9360
function zenerₖ_σ(Eₖ::Float64, Eₕ::Float64, ηₖ::Float64, ε::Array, t)
	σ = missing
	Δε = missing
    return σ, Δε
end;

# ╔═╡ 073dd2f7-cf60-4e87-9f64-21bc51d162d3
function plot_zenerk_σ(time, load; makie=CairoMakie)
	σ_Zenerk, Δε = zenerₖ_σ(20.,20.,10., load, time);

	σfigure = makie.Figure()

	σaxis = makie.Axis(
		σfigure[1,1],
		ylabel="Stress σ", 
		xlabel="Time t", 
		title="Zener K"
	)
	
	makie.lines!(
		σaxis,
		0:0.01:1.5,
		σ_Zenerk
	)

	return σfigure
end;

# ╔═╡ a7b0318e-796a-48c6-a8fb-0f008dcfd37e
function plot_zenerk_ε(time, load; makie=CairoMakie)
	ε_Zenerk, Δσ = zenerₖ_ε(2.,2.,0.2, load, time)

	εfigure = CairoMakie.Figure()

	εaxis = CairoMakie.Axis(
		εfigure[1,1],
		ylabel="Strain ε",
		xlabel="Time t",
		title="Zener K"
	)
	
	CairoMakie.lines!(
		εaxis,
		time,
		ε_Zenerk
	)

	return εfigure
end;

# ╔═╡ 164fe410-f55b-48f3-846d-41a2ee39fb63
md"""
### Zener M Model
"""

# ╔═╡ 2af063e6-9916-47df-92c7-229ce46a4548
md"""
Derive the differential equation for the Zener M Model.
"""

# ╔═╡ 4bfca4c8-d25a-4176-8c4b-301d7b56fa34
md"Show the solution persistently $(@bind show_zenerm CheckBox())"

# ╔═╡ f4765021-35ae-40d9-90bd-97ade341fbe9
md"""
### Task 2 – Implementing the Zener M Model
"""

# ╔═╡ 482f75ac-82d4-40fb-b30d-b30939cc611e
md"""
#### Implement the relaxation test
"""

# ╔═╡ 7ff75552-6b32-4ab0-9550-0691361fd2b8
function zenerₘ_σ(Eₘ::Float64, Eₕ::Float64, ηₘ::Float64, ε::Vector, t)
	σ = missing
	Δε = missing
    return σ, Δε
end;

# ╔═╡ 6f3db9dd-105f-4825-9a70-c288a328fce7
function plot_zenerm_σ(load, time; makie=CairoMakie)
	σ_Zenerm, Δε = zenerₘ_σ(20.,10.,5., load, time);

	figure = makie.Figure()
	
	axis = makie.Axis(
		figure[1,1],
		ylabel="Stress σ",
		xlabel="Time t",
		title="Zener M"
	)
	
	makie.lines!(
		axis,
		time,
		σ_Zenerm,
	)
	
	return figure
end;

# ╔═╡ b969d56a-a523-4814-89b7-9bd051cfd267
md"""
#### Implement the creep test
"""

# ╔═╡ 9ed56e01-d84c-4acb-bb22-c79b130885e1
function zenerₘ_ε(Eₘ::Float64, Eₕ::Float64, ηₘ::Float64, σ::Vector, t)
	Δσ = missing
	ε = missing
    return ε, Δσ
end;

# ╔═╡ 4662390a-ccef-4a26-b7ed-6171ebc00f93
function plot_zenerm_ε(load,time;makie=CairoMakie)
	ε_Zenerm, Δσ = zenerₘ_ε(20.,10.,1., load, time)

	f = makie.Figure();
	a = makie.Axis(
		f[1,1],
		ylabel="Strain ε",
		xlabel="Zeit t",
		title="Zener M",
		)
	
	makie.lines!(
		a,
		0:0.01:1.5,
		ε_Zenerm
	)

	return f
end;

# ╔═╡ 1d0095ca-ea5b-403e-b8c8-de033276ea9c
md"""
## Additional Task
"""

# ╔═╡ 6ed795ec-ed88-44b7-abe0-f1fab3f912e1
model = """<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   id="svg850"
   xml:space="preserve"
   width="100%"
   height="200"
   viewBox="0 0 271.90948 144.33019"
   sodipodi:docname="model.svg"
   inkscape:version="1.0.2 (e86c870879, 2021-01-15)"><metadata
     id="metadata856"><rdf:RDF><cc:Work
         rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" /><dc:title></dc:title></cc:Work></rdf:RDF></metadata><defs
     id="defs854"><marker
       inkscape:stockid="Arrow2Lstart"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Lstart"
       style="overflow:visible"
       inkscape:isstock="true"><path
         id="path3796"
         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
         transform="matrix(1.1,0,0,1.1,1.1,0)" /></marker><marker
       inkscape:stockid="Arrow2Lstart"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Lstart-9"
       style="overflow:visible"
       inkscape:isstock="true"><path
         inkscape:connector-curvature="0"
         id="path3796-2"
         style="fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.625;stroke-linejoin:round;stroke-opacity:1"
         d="M 8.7185878,4.0337352 -2.2072895,0.01601326 8.7185884,-4.0017078 c -1.7454984,2.3720609 -1.7354408,5.6174519 -6e-7,8.035443 z"
         transform="matrix(1.1,0,0,1.1,1.1,0)" /></marker></defs><sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1900"
     inkscape:window-height="1033"
     id="namedview852"
     showgrid="false"
     inkscape:zoom="2.8362839"
     inkscape:cx="116.09111"
     inkscape:cy="85.320702"
     inkscape:window-x="1929"
     inkscape:window-y="36"
     inkscape:window-maximized="1"
     inkscape:current-layer="g858"
     inkscape:document-rotation="0" /><g
     id="g858"
     inkscape:groupmode="layer"
     inkscape:label="ink_ext_XXXXXX"
     transform="matrix(1.3333333,0,0,-1.3333333,-42.949922,148.12395)"><path
       style="fill:none;stroke:#000000;stroke-width:0.724253;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="m 159.27205,23.325559 h 48.53171"
       id="path3013"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.672093;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="M 108.98046,23.344479 H 65.900459"
       id="path3017"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.631139;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="m 207.48801,48.343666 h 11.64014"
       id="path3021"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.631139;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="M 54.58156,48.418542 H 66.221692"
       id="path3021-8"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.721302;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="M 207.409,23.325556 V 76.873742"
       id="path3757"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.721302;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="M 66.264857,23.344477 V 76.873742"
       id="path3759"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.721302;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
       d="m 65.878355,76.542834 h 5.018101"
       id="path3761"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.52575;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:3.6;stroke-dasharray:none;stroke-opacity:1;marker-start:url(#Arrow2Lstart)"
       d="M 36.382263,48.418542 H 48.022395"
       id="path3021-8-7"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.52575;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:3.6;stroke-dasharray:none;stroke-opacity:1;marker-start:url(#Arrow2Lstart-9)"
       d="M 235.38397,48.343666 H 223.74385"
       id="path3021-8-7-2"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.75px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m 185.89465,63.198896 -2.37987,-4.495319 -5.28861,7.404054 -4.75975,-7.139624 -5.55304,7.932916 -4.75975,-7.932916 -5.28861,7.668485 -5.02418,-7.404054 -5.02418,7.668485 -2.90874,-4.230888 h -9.51949 v 27.765204 l 33.31824,-0.26443"
       id="path4313"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.75px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m 185.89465,63.198896 h 12.9571 v 27.236343 h -20.62558"
       id="path4315"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.75px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="M 151.92175,94.612192 H 178.473 v -8.601108 h -26.73823"
       id="path4335"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.75px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="M 168.56302,93.396818 V 87.132967"
       id="path4337"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.765814px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m 207.75959,76.873742 h -8.5773"
       id="path4339"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.755241px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m 135.39108,76.68465 h -15.0225 l -3.35322,-5.616638 -5.7005,10.043873 -6.43823,-9.845639 -6.438199,9.647403 -6.505277,-9.184856 -6.237019,9.515248 -6.572338,-10.176029 -6.035824,10.308185 -2.586027,-4.833501"
       id="path4341"
       inkscape:connector-curvature="0" /><path
       style="fill:none;stroke:#000000;stroke-width:0.75px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
       d="m 108.74706,23.269887 3.5037,4.627534 5.75136,-9.717818 6.47855,9.850034 5.94968,-10.048357 6.61077,10.048357 6.21411,-10.378897 6.61077,10.246681 5.48693,-10.180576 3.91912,5.608714"
       id="path4343"
       inkscape:connector-curvature="0" /><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.75"
       x="132.08995"
       y="-2.8453281"
       id="text1659"
       transform="scale(1,-1)"><tspan
         sodipodi:role="line"
         id="tspan1657"
         x="132.08995"
         y="-2.8453281"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.75">E</tspan></text><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.75"
       x="92.566765"
       y="-88.650253"
       id="text1663"
       transform="scale(1,-1)"><tspan
         sodipodi:role="line"
         id="tspan1661"
         x="92.566765"
         y="-88.650253"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.75">Eₕ</tspan></text><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.487246"
       x="162.81525"
       y="-44.737888"
       id="text1667"
       transform="scale(0.99893474,-1.0010664)"><tspan
         sodipodi:role="line"
         id="tspan1665"
         x="162.81525"
         y="-44.737888"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.487246">Eₖ</tspan></text><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.75"
       x="163.15627"
       y="-103.44897"
       id="text1671"
       transform="scale(1,-1)"><tspan
         sodipodi:role="line"
         id="tspan1669"
         x="163.15627"
         y="-103.44897"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.75">ηₖ</tspan></text><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.75"
       x="31.442442"
       y="-54.734127"
       id="text1675"
       transform="scale(1,-1)"><tspan
         sodipodi:role="line"
         id="tspan1673"
         x="31.442442"
         y="-54.734127"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.75">σ</tspan></text><text
       xml:space="preserve"
       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;line-height:1.25;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.75"
       x="227.1093"
       y="-54.058971"
       id="text1675-7"
       transform="scale(1,-1)"><tspan
         sodipodi:role="line"
         id="tspan1673-8"
         x="227.1093"
         y="-54.058971"
         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:14px;font-family:sans-serif;-inkscape-font-specification:'sans-serif, Normal';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;stroke-width:0.75">σ</tspan></text></g></svg>""";

# ╔═╡ 5d8cfde5-17c6-424e-8a49-595ba67083d3
HTML(model)

# ╔═╡ 8c359d20-1e58-4b02-b896-e2f554a1ccda
md"Show solution persistently $(@bind show_zusatz CheckBox())"

# ╔═╡ 54189a0f-2edc-4bec-aec6-870124530f34
md"""
You can implement the above model as well, just like we did for the others. Use their code as reference. If you want to plot your result, click on the little eye next to the plots above to check out how the plots are implemented there.
"""

# ╔═╡ 5104e137-8c8f-4851-b0e8-afcae492844b
begin
	hint(text;blur=true) = blur ? Markdown.MD(
		Markdown.Admonition("hint", "Help"[text])) : Markdown.MD(Markdown.Admonition("note", "Help", [text]))

	warning(text) = Markdown.MD(Markdown.Admonition("warning", "Warning", [text]))

	yays = [ md"Good job! 🐣", md"Yes 👍", md"Splendid! 🎉", md"Nicely done! 🐦",
		md"Well done! 🐤", md"Nice work! 🐧", md"Nice! 🐖", md"Very nice! 🐿" ]

	correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Correct!", 	[text]))
	
	still_missing(text=md"Replace `Missing` with your answer", titel="Not yet! 🦦") =
		Markdown.MD(Markdown.Admonition("warning", titel, [text]))

	keep_working(text=md"This is not the correct answer, try again! 🦥") =
		Markdown.MD(Markdown.Admonition("danger", "Wrong", [text]))

	solution(text; blur=true) = blur ? Markdown.MD(Markdown.Admonition("hint", 
		"Solution", [text])) : Markdown.MD(Markdown.Admonition("note", "Solution", [text]))

	svg(path) = HTML(open(f->read(f, String), path))
end;

# ╔═╡ 4212c8a7-9b68-49e0-beb9-97898531c853
if σₖ === missing
	still_missing()
elseif σₖ == Eₖ*εₖ + ηₖ*ε̇ₖ
	correct()
else
	keep_working()
end

# ╔═╡ 093d41b0-e84d-4b00-9575-841f0ccae762
if (@isdefined σ) && σ === missing
	still_missing()
elseif !(@isdefined σₕ) || !(@isdefined σ)
	keep_working(md"One Variables is still missing")
elseif σ == σₕ == σₖ
	correct()
else
	keep_working()
end

# ╔═╡ 4c428f95-90c0-4398-bd41-b93b593e5cbf
if εₕ === missing || ε === missing
	still_missing()
elseif εₕ == σₕ/Eₕ && ε == εₖ + εₕ
	correct()
else
	still_missing()
end

# ╔═╡ 3dcee869-c95f-46fa-89d4-c8ff0de26788
begin
	zenerₖ_ε_test, _ = zenerₖ_ε(1.,1.,1.,load,time)

	if zenerₖ_ε_test === missing
		zener_k_ε_implemented = false
		still_missing()
	elseif LinearAlgebra.norm(zenerₖ_ε_test) ≈ 0.18389034737693702
		zener_k_ε_implemented = true
		correct()
	else
		zener_k_ε_implemented = false
		keep_working()
	end
end

# ╔═╡ 1bd5b1ff-4235-43d5-a4b1-5da9390e9302
if zener_k_ε_implemented == true
	plot_zenerk_ε(time,load)
end

# ╔═╡ f71f93cb-ca4f-4c89-84ec-67abf9a0acee
begin
	zener_k_σ_test, _ = zenerₖ_σ(1.,1.,1.,load,time)

	if zener_k_σ_test === missing
		zener_k_σ_implemented = false
		still_missing()
	elseif LinearAlgebra.norm(zener_k_σ_test) ≈ 0.08269810574187134
		zener_k_σ_implemented = true
		correct()
	else
		zener_k_σ_implemented = false
		keep_working()
	end
end

# ╔═╡ d893f8f3-bfee-4fd7-aa65-f2ea65149e57
if zener_k_σ_implemented == true
	plot_zenerk_σ(time, load)
end

# ╔═╡ fbb7d4d8-0727-4186-ae72-540662c547c7
solution(md"""
The formulation for the Maxwell and the Hooke elements respectively

```math
\begin{align}
 \dot{\varepsilon}_{\text{M}} &= \frac{\dot{\sigma}_\text{M}}{E_\text{M}} + \frac{\sigma_\text{M}}{\eta_{\text{M}}}\\
 \sigma_\text{H} &= E_\text{H}\,\varepsilon_\text{H}
\end{align}
```

and the equations for coupling the elements into the 3-parameter model

```math
\begin{align}
\sigma &= \sigma_{\text{H}} +\sigma_{\text{M}} \quad\rightarrow\quad \sigma_{\text{M}}=\sigma-\sigma_{\text{H}}, \\
\varepsilon &= \varepsilon_\text{H} = \varepsilon_\text{M}.
\end{align}
```

inserted into each other this yields

```math
\dot{\varepsilon}=\frac{\dot{\sigma}-E_\text{H}\,\dot{\varepsilon}}{E_\text{M}} + \frac{\sigma-E_\text{H}\,\varepsilon}{\eta_\text{M}},
```

and differently reshaped we get the differential equation in the following form

```math
\dot{\sigma}+\frac{E_\text{M}}{\eta_\text{M}}\,\sigma = \left(E_\text{H}+E_\text{M}\right)\,\dot{\varepsilon} + \frac{E_\text{H}E_\text{M}}{\eta_\text{M}}\,\varepsilon 
```

Alas, the differential equations for both the Zener K and the Zener M model are of the same type. The only difference lies in the choice and combination of the model parameters. 

The initial and final conditions at prescribed constant stress $σ(t) = \tilde{σ}$ then take on the following form

```math
\varepsilon(0) = \frac{\tilde{\sigma}}{E_\text{H}+E_\text{M}} \qquad\text{und}\qquad
\varepsilon(\infty) = \frac{\tilde{\sigma}}{E_\text{H}}
```

Again, as in the Zener K model, the dampners initial strain is zero $ε_η(t=0) = 0$.
The inital stress is therefore gained from the two spring elements in parallel.
For $t → ∞$ the dampner relaxes compleatly.
In the final state only the second spring leads to stress in the system.
The inital and final conditions at prescribed constant strain $\tilde{ε}(t) = ε$ looks therefore as follows

```math
\sigma(0) = \left(E_\text{H}+E_\text{M}\right)\tilde{\varepsilon}
\qquad\text{und}\qquad
\sigma(\infty) = E_\text{H}\,\tilde{\varepsilon}.
```

The last step is now to discretize the system.
We use again the finite difference scheme in the implicit euler fashion. 
This means that we use the values from the next time step $n+1$.

```math
\frac{\sigma_{n+1}-\sigma_n}{\Delta t}+\frac{E_\text{M}}{\eta_\text{M}}\,\sigma_{n+1} = \left(E_\text{H}+E_\text{M}\right)\,\frac{\varepsilon_{n+1}-\varepsilon_n}{\Delta t} + \frac{E_\text{H}E_\text{M}}{\eta_\text{M}}\,\varepsilon_{n+1} 
```

solve for stress $σₙ₊₁$ or for strain $εₙ₊₁$ the iteration scheme is gained

```math
\begin{align}
 \sigma_{n+1} &= \frac{\eta_\text{M}\,\sigma_n+\left(E_\text{H}+E_\text{M}\right)\eta_\text{M}\left(\varepsilon_{n+1} -\varepsilon_n\right)+E_\text{H}\,E_\text{M}\,\Delta t\,\varepsilon_{n+1}}{\eta_\text{M}+E_\text{M}\,\Delta t},\\
 \varepsilon_{n+1} &= \frac{\left(E_\text{H}+E_\text{M}\right)\eta_\text{M}\,\varepsilon_n + \eta_\text{M}\left(\sigma_{n+1}-\sigma_n\right)+E_\text{M}\,\Delta t\,\sigma_{n+1}}{\left(E_\text{H}+E_\text{M}\right)\eta_\text{M}+E_\text{H}\,E_\text{M}\,\Delta t}.
\end{align}
```	
"""; blur=!show_zenerm)

# ╔═╡ 52a7e04f-9f68-46ee-8e66-305433770e9f
begin
	zener_m_σ_test, _ = zenerₘ_σ(1.,1.,1.,load,time)

	if zener_m_σ_test === missing
		zener_m_σ_implemented = false
		still_missing()
	elseif LinearAlgebra.norm(zener_m_σ_test) ≈ 0.18875310221894373
		zener_m_σ_implemented = true
		correct()
	else
		zener_m_σ_implemented = false
		keep_working()
	end
end

# ╔═╡ 4d1f9b3e-6592-4b3d-adca-b5d85f61d34d
if zener_m_σ_implemented == true
	plot_zenerm_σ(load,time)
end

# ╔═╡ a53df56d-f6c4-4abf-83ad-7f0dd50a4439
begin
	zener_m_ε_test, _ = zenerₘ_ε(1.,1.,1.,load,time)

	if zener_m_ε_test === missing
		zener_m_ε_implemented = false
		still_missing()
	elseif LinearAlgebra.norm(zener_m_ε_test) ≈ 0.08015765816788616
		zener_m_ε_implemented = true
		correct()
	else
		zener_m_ε_implemented = false
		keep_working()
	end
end

# ╔═╡ 0c71aedf-c4e3-45f2-86cd-fde74fc3d32a
if zener_m_ε_implemented == true
	plot_zenerm_ε(load,time)
end

# ╔═╡ 983f09cd-2136-47f6-99d3-17ef2dd1aa0c
solution(md"""
**Stress Relationship**
	
$\sigma = \sigma_K + \sigma_E$
	
	
$\sigma_K = \sigma_{KE} + \sigma_{K\eta}$
	
	
$\sigma_K=\sigma_H$

**Strain Relationship**
	
	
$\varepsilon = \varepsilon_K + \varepsilon_H$
	
	
$\varepsilon_{KE} = \varepsilon_{K\eta}$

**Strainrate**
```math
	\dot{\varepsilon} = \dot{\varepsilon}_K + \dot{\varepsilon}_H
```

**Element Relationship**
```math
	\sigma_E = E\varepsilon
```
$$\sigma_{KE} = E_K \varepsilon_K$$
$$\sigma_{K\eta} = \eta_K \dot{\varepsilon}_K$$
$$\sigma_H = E_H \varepsilon_H$$

**Differential Equation**
```math
\begin{align}
\dot{\varepsilon} &= \dot{\varepsilon}_K + \dot{\varepsilon}_H \\
        &= \frac{1}{\eta_K}\sigma_{K\eta} + \frac{1}{E_H}\dot{\sigma}_H\\
        &= \frac{1}{\eta_K}\sigma_{K\eta} +\frac{1}{E_H}(\dot{\sigma} - E\dot{\varepsilon})\\
        &= \frac{1}{\eta_K}(\sigma_K - \sigma_{KE}) + \frac{1}{E_H} \dot{\sigma} - \frac{E}{E_H}\dot{\varepsilon}\\
        &= \frac{1}{\eta_K} (\sigma - \sigma_E - E_K\varepsilon_K)+\frac{1}{E_H} \dot{\sigma} - \frac{E}{E_H}\dot{\varepsilon}\\
        &= \frac{1}{\eta_K} \sigma - \frac{1}{\eta_K}E\varepsilon - \frac{E_K}{\eta_K} \varepsilon + \frac{E_K}{\eta_K E_H} \sigma_H + \frac{1}{E_H} \dot{\sigma} - \frac{E}{E_H}\dot{\varepsilon}\\
        \frac{E_H+E}{E_H} \dot{\varepsilon}&= \frac{1}{\eta_K} \sigma - \frac{1}{\eta_K}E\varepsilon - \frac{E_K}{\eta_K} \varepsilon + \frac{E_K}{\eta_K E_H} (\sigma-E\varepsilon) + \frac{1}{E_H} \dot{\sigma} \\
        &= \frac{1}{\eta_K} \sigma - \frac{1}{\eta_K}E\varepsilon - \frac{E_K}{\eta_K} \varepsilon + \frac{E_K}{\eta_K E_H} \sigma- \frac{E_K E}{\eta_K E_H} \varepsilon + \frac{1}{E_H} \dot{\sigma} \\
\end{align}
```

Finally we reformulate for $σ$ or $ε$ respectively. 

```math
\frac{E_H + E}{E_H}\dot{\varepsilon} + \left(\frac{E_K+E}{\eta_K}+\frac{E_K E}{\eta_K E_H}\right)\varepsilon = \frac{1}{E_H} \dot{\sigma} + \frac{E_H + E_K}{E_H\eta_K}\sigma.
```

**Numerical Solution**

Let's use finite differences in the implicit euler scheme ($ε = εₙ₊₁$)

```math
\frac{E_H + E}{E_H} \frac{\varepsilon_{n+1} - \varepsilon_n}{\Delta t} + \left(\frac{E_K+E}{\eta_K}+\frac{E}{\eta_K}\right)\varepsilon_{n+1} = \frac{1}{E_H} \frac{\sigma_{n+1}-\sigma_n}{\Delta t} + \frac{E_H + E_K}{E_H\eta_K}\sigma_{n+1}.
```

Now we can solve for one of the variables as an unknown

```math
	\varepsilon_{n+1} = \frac{\eta_K(\sigma_{n+1}-\sigma_n) + (E_H+E_K)\Delta t \sigma_{n+1} + \eta_K(E_H+E)\varepsilon_n}{\eta_K(E_H+E)+(E_K+2E)\Delta t E_H}
```

the initial and final conditions are 

```math
	\varepsilon(0)=\frac{\tilde{\sigma}}{E_H+E} \qquad \text{und} \qquad \varepsilon(\infty)=\frac{E_H+E_K}{E_H(E_K+2E)}\tilde{\sigma}.
```

"""; blur=!show_zusatz)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CairoMakie = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
Ferrite = "c061ca5d-56c9-439f-9c0e-210fe06d3992"
FerriteGmsh = "4f95f4f8-b27c-4ae5-9a39-ea55e634e36b"
FerriteViz = "59d0093e-b1f1-4fb7-ac85-ab57e45f39d9"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Luxor = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
StringDistances = "88034a9c-02f8-509d-84a9-84ec65e18404"
Tensors = "48a634ad-e948-5137-8d70-aa71f2a747f4"

[compat]
CairoMakie = "~0.8.13"
Ferrite = "~0.3.9"
FerriteGmsh = "~1.0.0"
FerriteViz = "~0.1.2"
Luxor = "~3.5.0"
PlutoUI = "~0.7.48"
StringDistances = "~0.11.2"
Tensors = "~1.13.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "b47260279f6946cc1266cf5d4c9d6cfbaa207db7"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "50c3c56a52972d78e8be9fd135bfb91c9574c140"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.1.1"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e092fa223bf66a3c41f9c022bd074d916dc303e7"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Automa]]
deps = ["TranscodingStreams"]
git-tree-sha1 = "ef9997b3d5547c48b41c7bd8899e812a917b409d"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "0.8.4"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "01b8ccb13d68535d73d2b0c23e39bd23155fb712"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.1.0"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "16351be62963a67ac4083f748fdb3cca58bfd52f"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "8873e196c2eb87962a2048b3b8e08946535864a1"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+2"

[[deps.CEnum]]
git-tree-sha1 = "389ad5c84de1ae7cf0e28e381131c98ea87d54fc"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.5.0"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "71aa551c5c33f1a4415867fe06b7844faadb0ae9"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.1.1"

[[deps.CairoMakie]]
deps = ["Base64", "Cairo", "Colors", "FFTW", "FileIO", "FreeType", "GeometryBasics", "LinearAlgebra", "Makie", "SHA"]
git-tree-sha1 = "387e0102f240244102814cf73fe9fbbad82b9e9e"
uuid = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
version = "0.8.13"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "009060c9a6168704143100f36ab08f06c2af4642"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.2+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "3e4b134270b372f2ed4d4d0e936aabaefc1802bc"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON", "Test"]
git-tree-sha1 = "61c5334f33d91e570e1d0c3eb5465835242582c4"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "b5278586822443594ff615963b0c09755771b3e0"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.26.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "c7e3a542b999843086e2f29dac96a618c105be1d"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.12"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "9d9e93d19c912ee6f0f3543af0d8839079dbd0d7"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.114"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e51db81749b0777b2147fbe7b783ee79045b8e99"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.4+1"

[[deps.Extents]]
git-tree-sha1 = "81023caa0021a41712685887db1fc03db26f41f5"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.4"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "4820348781ae578893311153d69049a93d05f39d"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.8.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4d81ed14783ec49ce9f2e168208a12ce1815aa25"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+1"

[[deps.FLTK_jll]]
deps = ["Artifacts", "Fontconfig_jll", "FreeType2_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "Xorg_libXft_jll", "Xorg_libXinerama_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "72a4842f93e734f378cf381dae2ca4542f019d23"
uuid = "4fce6fc7-ba6a-5f4c-898f-77e99806d6f8"
version = "1.3.8+0"

[[deps.Ferrite]]
deps = ["EnumX", "LinearAlgebra", "NearestNeighbors", "Preferences", "Reexport", "SparseArrays", "Tensors", "WriteVTK"]
git-tree-sha1 = "a31b9d4dd58e00686e5da175dab11667af3108b6"
uuid = "c061ca5d-56c9-439f-9c0e-210fe06d3992"
version = "0.3.14"

    [deps.Ferrite.extensions]
    FerriteBlockArrays = "BlockArrays"
    FerriteMetis = "Metis"

    [deps.Ferrite.weakdeps]
    BlockArrays = "8e7c35d0-a365-5155-bbbb-fb81a777f24e"
    Metis = "2679e427-3c69-5b7f-982b-ece356f1e94b"

[[deps.FerriteGmsh]]
deps = ["Ferrite", "Gmsh"]
git-tree-sha1 = "702427f9f6b2d3e39da3bfab4eea7d02f459e404"
uuid = "4f95f4f8-b27c-4ae5-9a39-ea55e634e36b"
version = "1.0.1"

[[deps.FerriteViz]]
deps = ["Ferrite", "LinearAlgebra", "Makie", "Tensors"]
git-tree-sha1 = "852936d63b908540193397a28d6d3bc228a26cfa"
uuid = "59d0093e-b1f1-4fb7-ac85-ab57e45f39d9"
version = "0.1.3"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "2dd20384bf8c6d411b5c7370865b1e9b26cb2ea3"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.6"

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

    [deps.FileIO.weakdeps]
    HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.Formatting]]
deps = ["Logging", "Printf"]
git-tree-sha1 = "fb409abab2caf118986fc597ba84b50cbaf00b87"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.3"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a2df1b776752e3f344e5116c06d75a10436ab853"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.38"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "907369da0f8e80728ab49c1c7e09327bf0d6d999"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.1.1"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "b5c7fe9cea653443736d264b85466bad8c574f4a"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.9.9"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1ed150b39aebcc805c26b93a8d0122c940f64ce2"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.14+0"

[[deps.GLU_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg"]
git-tree-sha1 = "65af046f4221e27fb79b28b6ca89dd1d12bc5ec7"
uuid = "bd17208b-e95e-5925-bf81-e2f59b3e5c61"
version = "9.0.1+0"

[[deps.GMP_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "781609d7-10c4-51f6-84f2-b8444358ff6d"
version = "6.3.0+0"

[[deps.GeoFormatTypes]]
git-tree-sha1 = "59107c179a586f0fe667024c5eb7033e81333271"
uuid = "68eda718-8dee-11e9-39e7-89f7f65f511f"
version = "0.4.2"

[[deps.GeoInterface]]
deps = ["DataAPI", "Extents", "GeoFormatTypes"]
git-tree-sha1 = "f4ee66b6b1872a4ca53303fbb51d158af1bf88d4"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.4.0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "b62f2b2d76cee0d61a2ef2b3118cd2a3215d3134"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.11"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "48b5d4c75b2c9078ead62e345966fa51a25c05ad"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.2+1"

[[deps.Gmsh]]
deps = ["gmsh_jll"]
git-tree-sha1 = "4d4dedef84147934837c683538467cea54c44d44"
uuid = "705231aa-382f-11e9-3f0c-b7cb4346fdeb"
version = "0.2.2"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "f57a64794b336d4990d90f80b147474b869b1bc4"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.9.2"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HDF5_jll]]
deps = ["Artifacts", "JLLWrappers", "LibCURL_jll", "Libdl", "OpenSSL_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "4cc2bb72df6ff40b055295fdef6d92955f9dede8"
uuid = "0234f1f7-429e-5d53-9886-15a909be8d59"
version = "1.12.2+2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "2e4520d67b0cef90865b3ef727594d2a58e0e1f8"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.11"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "437abb322a41d527c197fa800455f79d414f0a3c"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.8"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "355e2b974f2e3212a75dfb60519de21361ad3cb7"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.9"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0936ba688c6d201805a83da835b55c61a180db52"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.11+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "d1b1b796e47d94588b3757fe84fbf65a5ec4a80d"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.5"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "LazyArtifacts", "Libdl"]
git-tree-sha1 = "10bd689145d2c3b2a9844005d01087cc1194e79e"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2024.2.1+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "88a101217d7cb38a7b481ccd50d21876e1d1b0e0"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.15.1"

    [deps.Interpolations.extensions]
    InterpolationsUnitfulExt = "Unitful"

    [deps.Interpolations.weakdeps]
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

    [deps.IntervalSets.weakdeps]
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "fa6d0bcff8583bac20f1ffa708c3913ca605c611"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.5"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "25ee0be4d43d0269027024d75a24c24d6c6e590c"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.4+0"

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "7d703202e65efa1369de1279c162b915e245eed1"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.9"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "36bdbc52f13a7d1dcb0f3cd694e01677a515655b"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "854a9c268c43b77b0a27f22d7fab8d33cdb3a731"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"
version = "1.11.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c6ce1e19f3aec9b59186bdf06cdf3c4fc5f5f3e6"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.50.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "61dfdba58e585066d8bce214c5a51eaa0539f269"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "84eef7acd508ee5b3e956a2ae51b05024181dee0"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.2+0"

[[deps.Librsvg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pango_jll", "Pkg", "gdk_pixbuf_jll"]
git-tree-sha1 = "ae0923dab7324e6bc980834f709c4cd83dd797ed"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.54.5+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "b404131d06f7886402758c9ce2214b636eb4d54a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "edbf5309f9ddf1cab25afc344b1e8150b7c832f9"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.2+0"

[[deps.LightXML]]
deps = ["Libdl", "XML2_jll"]
git-tree-sha1 = "3a994404d3f6709610701c7dabfc03fed87a81f8"
uuid = "9c8b4983-aa76-5018-a973-4c85ecc9e179"
version = "0.9.1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LinearElasticity_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "71e8ee0f9fe0e86a8f8c7f28361e5118eab2f93f"
uuid = "18c40d15-f7cd-5a6d-bc92-87468d86c5db"
version = "5.0.0+0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.Luxor]]
deps = ["Base64", "Cairo", "Colors", "Dates", "FFMPEG", "FileIO", "Juno", "LaTeXStrings", "Random", "Requires", "Rsvg"]
git-tree-sha1 = "8fd7cb8db7dc4f575373825963079dbe54581f32"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "3.5.0"

[[deps.METIS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "1c20a46719c0dc4ec4e7021ca38f53e1ec9268d9"
uuid = "d00139f3-1899-568f-a2f0-47f597d42d70"
version = "5.1.2+1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "oneTBB_jll"]
git-tree-sha1 = "f046ccd0c6db2832a9f639e2c669c6fe867e5f4f"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2024.2.0+0"

[[deps.MMG_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "LinearElasticity_jll", "Pkg", "SCOTCH_jll"]
git-tree-sha1 = "70a59df96945782bb0d43b56d0fbfdf1ce2e4729"
uuid = "86086c02-e288-5929-a127-40944b0018b7"
version = "5.6.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Makie]]
deps = ["Animations", "Base64", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "Contour", "Distributions", "DocStringExtensions", "FFMPEG", "FileIO", "FixedPointNumbers", "Formatting", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageIO", "IntervalSets", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MakieCore", "Markdown", "Match", "MathTeXEngine", "Observables", "OffsetArrays", "Packing", "PlotUtils", "PolygonOps", "Printf", "Random", "RelocatableFolders", "Serialization", "Showoff", "SignedDistanceFields", "SparseArrays", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "UnicodeFun"]
git-tree-sha1 = "b0323393a7190c9bf5b03af442fc115756df8e59"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.17.13"

[[deps.MakieCore]]
deps = ["Observables"]
git-tree-sha1 = "fbf705d2bdea8fc93f1ae8ca2965d8e03d4ca98c"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.4.0"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Match]]
git-tree-sha1 = "1d9bc5c1a6e7ee24effb93f175c9342f9154d97f"
uuid = "7eb4fadd-790c-5f42-8a69-bfa0b872bfbf"
version = "1.2.0"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "Test"]
git-tree-sha1 = "114ef48a73aea632b8aebcb84f796afcc510ac7c"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.4.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "8a3271d8309285f4db73b4f662b1b290c715e85e"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.21"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "d92b107dbb887293622df7697a2223f9f8176fcd"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OCCT_jll]]
deps = ["Artifacts", "FreeType2_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "Xorg_libXft_jll", "Xorg_libXinerama_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "acc8099ae8ed10226dc8424fb256ec9fe367a1f0"
uuid = "baad4e97-8daa-5946-aac2-2edac59d34e1"
version = "7.6.2+2"

[[deps.Observables]]
git-tree-sha1 = "7438a59546cf62428fc9d1bc94729146d37a7225"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.5"

[[deps.OffsetArrays]]
git-tree-sha1 = "39d000d9c33706b8364817d8894fae1548f40295"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.14.2"
weakdeps = ["Adapt"]

    [deps.OffsetArrays.extensions]
    OffsetArraysAdaptExt = "Adapt"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "97db9e07fe2091882c765380ef58ec553074e9c7"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.3"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "8292dd5c8a38257111ada2174000a33745b06d4e"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.2.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ad31332567b189f508a3ea8957a2640b1147ab00"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+1"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "67186a2bc9a90f9f85ff3cc8277868961fb57cbd"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.4.3"

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "1155f6f937fa2b94104162f01fa400e192e4272f"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.4.2"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e127b609fb9ecba6f201ba7ab753d5a605d53801"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.54.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f9501cc0430a26bc3d156ae1b5b0c1b47af4d6da"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.3"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Profile]]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"
version = "1.11.0"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "8f6bc219586aef8baf0ff9a5fe16ee9c70cb65e4"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.10.2"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "8b3fc30bc0390abdce15f8822c889f669baed73d"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "22c5201127d7b243b9ee1de3b43c408879dff60f"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.3.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "3d3dc66eb46568fb3a5259034bfc752a0eb0c686"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.0.0"

[[deps.SCOTCH_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7110b749766853054ce8a2afaa73325d72d32129"
uuid = "a8d0f55d-b80e-548d-aff6-1a04c175f0f9"
version = "6.1.3+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "52af86e35dd1b177d051b12681e1c581f53c281b"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Random", "Statistics", "Test"]
git-tree-sha1 = "d263a08ec505853a5ff1c1ebde2070419e3f28e9"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "2da10356e31327c7096832eb9cd86307a50b1eb6"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.3"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "777657803913ffc7e8cc20f0fd04b634f871af8f"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.8"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StringDistances]]
deps = ["Distances", "StatsAPI"]
git-tree-sha1 = "5b2ca70b099f91e54d98064d5caf5cc9b541ad06"
uuid = "88034a9c-02f8-509d-84a9-84ec65e18404"
version = "0.11.3"

[[deps.StructArrays]]
deps = ["ConstructionBase", "DataAPI", "Tables"]
git-tree-sha1 = "9537ef82c42cdd8c5d443cbc359110cbb36bae10"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.21"

    [deps.StructArrays.extensions]
    StructArraysAdaptExt = "Adapt"
    StructArraysGPUArraysCoreExt = ["GPUArraysCore", "KernelAbstractions"]
    StructArraysLinearAlgebraExt = "LinearAlgebra"
    StructArraysSparseArraysExt = "SparseArrays"
    StructArraysStaticArraysExt = "StaticArrays"

    [deps.StructArrays.weakdeps]
    Adapt = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    KernelAbstractions = "63c18a36-062a-441e-b654-da1e3ab1ce7c"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Tensors]]
deps = ["ForwardDiff", "LinearAlgebra", "SIMD", "SnoopPrecompile", "StaticArrays", "Statistics"]
git-tree-sha1 = "71f054343e85ab1eab12bf8336004309002ff82d"
uuid = "48a634ad-e948-5137-8d70-aa71f2a747f4"
version = "1.13.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "SIMD", "UUIDs"]
git-tree-sha1 = "38f139cc4abf345dd4f22286ec000728d5e8e097"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.10.2"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.VTKBase]]
git-tree-sha1 = "c2d0db3ef09f1942d08ea455a9e252594be5f3b6"
uuid = "4004b06d-e244-455f-a6ce-a5f9919cc534"
version = "1.0.1"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c1a7aa6219628fcd757dede0ca95e245c5cd9511"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "1.0.0"

[[deps.WriteVTK]]
deps = ["Base64", "CodecZlib", "FillArrays", "LightXML", "TranscodingStreams", "VTKBase"]
git-tree-sha1 = "5817a62d8a1d00ce36bb418aceafaa49cff81b65"
uuid = "64499a7a-5c06-52f2-abe2-ccb03c286192"
version = "1.18.2"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "a2fccc6559132927d4c5dc183e3e01048c6dcbd6"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "15e637a697345f6743674f1322beefbc5dcd5cfc"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+1"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "2b0e27d52ec9d8d483e2ca0b72b3cb1a8df5c27a"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+1"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "02054ee01980c90297412e4c809c8694d7323af3"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+1"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+1"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXft_jll]]
deps = ["Fontconfig_jll", "Libdl", "Pkg", "Xorg_libXrender_jll"]
git-tree-sha1 = "754b542cdc1057e0a2f1888ec5414ee17a4ca2a1"
uuid = "2c808117-e144-5220-80d1-69d4eaa9352c"
version = "2.3.3+1"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a1a7eaf6c3b5b05cb903e35e8372049b107ac729"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.5+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fee57a273563e273f0f53275101cd41a8153517a"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+1"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+1"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b9ead2d2bdb27330545eb14234a2e300da61232e"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "555d1076590a6cc2fdee2ef1469451f872d8b41b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+1"

[[deps.gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "86e7731be08b12fa5e741f719603ae740e16b666"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.10+0"

[[deps.gmsh_jll]]
deps = ["Artifacts", "Cairo_jll", "CompilerSupportLibraries_jll", "FLTK_jll", "FreeType2_jll", "GLU_jll", "GMP_jll", "HDF5_jll", "JLLWrappers", "JpegTurbo_jll", "LLVMOpenMP_jll", "Libdl", "Libglvnd_jll", "METIS_jll", "MMG_jll", "OCCT_jll", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "Xorg_libXft_jll", "Xorg_libXinerama_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d4cf3bb87fa0669f569e51f6f06cd083771bab65"
uuid = "630162c2-fc9b-58b3-9910-8442a8a132e6"
version = "4.10.2+1"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1827acba325fdcdf1d2647fc8d5301dd9ba43a9d"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.9.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "b70c870239dc3d7bc094eb2d6be9b73d27bef280"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.44+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "7dfa0fd9c783d3d0cc43ea1af53d69ba45c447df"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.oneTBB_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7d0ea0f4895ef2f5cb83645fa689e52cb55cf493"
uuid = "1317d2d5-d96f-522e-a858-c73665f53c3e"
version = "2021.12.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"
"""

# ╔═╡ Cell order:
# ╠═4fc88de5-456f-4ca3-8836-998628d09770
# ╟─6065849d-042a-4c75-b663-a86052f31d3c
# ╟─2d0debb7-7d67-43e1-aba8-85fcae635c0f
# ╟─0ec3a66f-f612-4264-9670-0ca974103902
# ╟─72ca782e-85b6-4d99-b1f8-35963aac0ccd
# ╟─8ba8a6e9-fef9-45cb-964b-1ab97e2436d4
# ╟─2c6c389e-95aa-46a7-af90-887221f1fa3c
# ╟─01de02df-e4e3-43da-b6fa-fcaee55e7eb2
# ╟─1e07342e-22b1-437e-8398-ef97c276a1df
# ╟─76508c42-b1ce-44a2-b6e9-0b83ccb375e4
# ╟─df4d49d3-6262-4156-a43e-346453ac19a3
# ╟─9e6f7e42-d8cd-4c18-816b-c31a2fe5ccb0
# ╟─2a21d8e8-4af9-40ed-9f15-24d0501ca00a
# ╠═2f775b07-32d8-482a-ba9a-841f57c81765
# ╟─3436bf12-bfd6-4d97-aa22-9c6725a11bf4
# ╠═19e97301-904f-43d6-85f4-7dd70d48357c
# ╟─4212c8a7-9b68-49e0-beb9-97898531c853
# ╟─8a4bf004-ef75-4eb3-8f87-5ebb70f6eb03
# ╠═e7b1666c-cbd1-493c-98f6-3345e5e617fa
# ╟─093d41b0-e84d-4b00-9575-841f0ccae762
# ╟─636ce699-1d4d-4368-8372-104258c52c8f
# ╠═7cd868d6-9b1d-42df-9246-226ace25abe5
# ╠═f1174e63-6c27-43e9-bcc2-502177183374
# ╟─4c428f95-90c0-4398-bd41-b93b593e5cbf
# ╟─f0d058b5-86fa-4d1c-81db-f89a9512cda9
# ╟─ca06cb3b-10dd-4ff7-a625-e2eeb665a707
# ╟─2195e334-afda-49f4-8bb5-ccf4d1740d3d
# ╟─d0579c0c-0147-48d8-860e-3b0f8db77547
# ╟─c11144ac-50c4-499e-8456-25f1f0be0303
# ╟─6b46d1e3-7c55-4b8b-830e-d8ac0dcde19f
# ╟─d25dc6d2-8c6c-4893-ba89-79537057f0af
# ╟─d27d7600-6f4f-4dc6-a955-2aacfb0cc59b
# ╟─0594e6ed-990d-4417-a432-ea6e9aadcc1e
# ╟─9f9f662b-6a87-4c49-8db7-aadbc02dc2a7
# ╟─c25ad9bc-df5b-448e-8579-5b99ef08fb4e
# ╠═7ac4ecf9-2530-44e7-b935-cbf4722b7b60
# ╟─6170206d-aee4-4796-972b-543062d62100
# ╠═778ebc7c-153f-4a1d-b285-57149b5750be
# ╟─9b9d21ae-2e18-4f1f-bdcd-ba99c444bb49
# ╠═72c830df-968c-4c7b-b81a-b78eb8531673
# ╟─3dcee869-c95f-46fa-89d4-c8ff0de26788
# ╟─1bd5b1ff-4235-43d5-a4b1-5da9390e9302
# ╟─f2144560-5d73-4d5c-9e86-a43b1bd95cd8
# ╠═69aa89fe-4d6f-4da1-975e-277d74fb9360
# ╟─f71f93cb-ca4f-4c89-84ec-67abf9a0acee
# ╟─d893f8f3-bfee-4fd7-aa65-f2ea65149e57
# ╟─073dd2f7-cf60-4e87-9f64-21bc51d162d3
# ╟─a7b0318e-796a-48c6-a8fb-0f008dcfd37e
# ╟─164fe410-f55b-48f3-846d-41a2ee39fb63
# ╟─2af063e6-9916-47df-92c7-229ce46a4548
# ╟─fbb7d4d8-0727-4186-ae72-540662c547c7
# ╟─4bfca4c8-d25a-4176-8c4b-301d7b56fa34
# ╟─f4765021-35ae-40d9-90bd-97ade341fbe9
# ╟─482f75ac-82d4-40fb-b30d-b30939cc611e
# ╠═7ff75552-6b32-4ab0-9550-0691361fd2b8
# ╟─52a7e04f-9f68-46ee-8e66-305433770e9f
# ╟─4d1f9b3e-6592-4b3d-adca-b5d85f61d34d
# ╟─6f3db9dd-105f-4825-9a70-c288a328fce7
# ╟─b969d56a-a523-4814-89b7-9bd051cfd267
# ╠═9ed56e01-d84c-4acb-bb22-c79b130885e1
# ╟─a53df56d-f6c4-4abf-83ad-7f0dd50a4439
# ╟─0c71aedf-c4e3-45f2-86cd-fde74fc3d32a
# ╟─4662390a-ccef-4a26-b7ed-6171ebc00f93
# ╟─1d0095ca-ea5b-403e-b8c8-de033276ea9c
# ╟─5d8cfde5-17c6-424e-8a49-595ba67083d3
# ╟─6ed795ec-ed88-44b7-abe0-f1fab3f912e1
# ╟─8c359d20-1e58-4b02-b896-e2f554a1ccda
# ╟─983f09cd-2136-47f6-99d3-17ef2dd1aa0c
# ╟─54189a0f-2edc-4bec-aec6-870124530f34
# ╟─5104e137-8c8f-4851-b0e8-afcae492844b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
