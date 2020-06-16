SOURCE="https://github.com/oguzhaninan/Buka/releases/download/v1.0.0/Buka-1.0.0-x86_64.AppImage"
OUTPUT="Buka.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	#wget --output-document=$(OUTPUT) --continue $(SOURCE)
	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

