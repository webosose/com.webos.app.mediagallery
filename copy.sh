scp -r ./qml/App root@192.168.0.22:/usr/palm/applications/com.webos.app.mediagallery/qml/
scp -P 6622 -r ./qml/App root@127.0.0.1:/usr/palm/applications/com.webos.app.avn.music/qml/
scp -P 22 -r ./qml/App root@192.168.0.17:/usr/palm/applications/com.webos.app.avn.music/qml/


scp -P 6622 -r root@127.0.0.1:/home/root/ImageList.json ImageList.json
scp -P 22 -r root@192.168.0.17:/home/root/log.txt log.txt


scp -P 6622 -r ./qml/App root@127.0.0.1:/usr/palm/applications/com.webos.app.avn.hvac/qml/

scp -P 6622 -r ./qml/App root@127.0.0.1:/usr/palm/applications/com.webos.app.avn.music/qml/


luna-send -n 1 luna://com.webos.service.applicationManager/launch '{"id":"com.webos.app.avn.hvac","params":{"appMode":"Image","folder":"190929"}}'
luna-send -n 1 luna://com.webos.service.applicationManager/launch '{"id":"com.webos.app.avn.music"}'

scp -P 22 -r root@192.168.0.17:/home/root/notFullList.log notFullList.log

scp -P 22 -r ./qml/App root@192.168.0.17:/usr/palm/applications/com.webos.app.avn.hvac/qml/


scp -P 22 -r root@192.168.0.17:/media/.thumbnail/2C25-16EA audioThumbnails/
scp -P 22 -r root@192.168.0.26:/home/root/launchpoints.log launchpoints.log

scp -P 22 -r ./qml/App root@192.168.0.26:/usr/palm/applications/com.webos.app.mediagallery/qml/