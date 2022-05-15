
   
function _peco_change_directory
  if [ (count $argv) ]
    peco --layout=top-down --query "$argv "|perl -pe 's/([ ()])/\\\\$1/g'|read foo
  else
    peco --layout=top-down |perl -pe 's/([ ()])/\\\\$1/g'|read foo
  end
  if [ $foo ]
    builtin cd $foo
    commandline -r ''
    commandline -f repaint
  else
    commandline ''
  end
end

function peco_change_directory
  begin
    echo $HOME/.config
#    ls -ad */* |grep -v \.git
#    ls -ad ~/*/*/*/ |grep -v Applications
    ls -ad ./*/ |grep -v Applications
    ls -ad ./*/*/ |grep -v Applications
    ls -ad ~/Desktop/*/*/ |grep -v Applications
    ls -ad ~/Downloads/*/*/ |grep -v Applications
    ls -ad ~/Documents/*/*/ |grep -v Applications
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_change_directory $argv
end
