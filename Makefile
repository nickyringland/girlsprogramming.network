# brew install wget gdal
# npm install -g topojson

australia.json: australian-states.json
	topojson -o australia.json -- states=australian-states.json

australian-states.json: ne_10m_admin_1_states_provinces_lakes.geojson
	ogr2ogr -where "admin='Australia'" -f GeoJSON australian-states.json ne_10m_admin_1_states_provinces_lakes.geojson

ne_10m_admin_1_states_provinces_lakes.geojson: ne_10m_admin_1_states_provinces_lakes.geojson.gz
	gunzip -k -f ne_10m_admin_1_states_provinces_lakes.geojson.gz

ne_10m_admin_1_states_provinces_lakes.geojson.gz:
	wget https://github.com/nvkelso/natural-earth-vector/raw/master/geojson/ne_10m_admin_1_states_provinces_lakes.geojson.gz
	touch ne_10m_admin_1_states_provinces_lakes.geojson.gz
