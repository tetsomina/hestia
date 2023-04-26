#!/bin/sh

# Simple wrapper script to launch games

# Old libs needed by some games
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH":/home/barbaross/Public/Games/libs

# Needed for music in doomretro and warcraft I
export SDL_SOUNDFONTS=/usr/share/soundfonts/FluidR3_GM.sf2

case "$1" in
bgee)
    cd ~/Public/Games/Baldurs_Gate/ || exit
    ./start.sh >/dev/null 2>&1
    ;;
bge2)
    cd ~/Public/Games/Baldurs_Gate_II/ || exit
    ./start.sh >/dev/null 2>&1
    ;;
iwdd)
    cd ~/Public/Games/Icewind_Dale/ || exit
    ./start.sh >/dev/null 2>&1
    ;;
pstm)
    cd ~/Public/Games/Planescape_Torment/ || exit
    ./start.sh >/dev/null 2>&1
    ;;
# nvwn)
#     cd ~/Public/Games/Neverwinter_Nights/bin/linux-x86/ || exit
#     ./nwmain-linux >/dev/null 2>&1
#     ;;
# dtdn)
#     cd ~/Public/Games/Darkest_Dungeon || exit
#     ./darkest.bin.x86_64
#     ;;
doom)
    #gzdoom >/dev/null
    doomretro -iwad ~/Public/Games/Doom/DOOM.WAD >/dev/null
    ;;
dom2)
    #gzdoom -iwad ~/Public/Games/Doom2/doom2/DOOM2.WAD >/dev/null
    doomretro -iwad ~/Public/Games/Doom/DOOM2.WAD >/dev/null
    ;;
wrct)
    stratagus -F -d ~/Public/Games/Stratagus/data.War1gus -u ~/Public/Games/Stratagus
    #dosbox -conf ~/Public/Games/Warcraft/dosbox_warcraft.conf ~/Public/Games/Warcraft/WAR.EXE
    ;;
wct2)
    stratagus -F -d ~/Public/Games/Stratagus/data.Wargus -u ~/Public/Games/Stratagus
    ;;
dblo)
    devilutionx
    ;;
 esmw)
     openmw
     ;;
*)
    echo "Usage: $(basename "$0") <game>"
    echo ""
    echo "Games: "
    echo "  bgee: Baldur's Gate"
    echo "  bge2: Baldur's Gate II"
    echo "  iwdd: Icewind Dale"
    echo "  pstm: Planescape Torment"
    echo "  wrct: Warcraft: Orcs and Humans"
    echo "  wct2: Warcraft II: Tides of Darkness"
    echo "  dblo: Diablo: Hellfire"
    echo "  esmw: Elder Scrolls: Morrowind"
    echo "  doom: Doom"
    echo "  dom2: Doom II"
    ;;
esac
