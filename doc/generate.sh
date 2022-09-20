cp ./template/README.md .
sed -i "s/{{ endpoint }}/$(gp url 3000)/" README.md