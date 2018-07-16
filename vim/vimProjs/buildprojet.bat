@echo off 
if "%1" == "" ( 
 echo "project name is [NULL]". 
) ELSE (
echo "building ..."
echo let g:proj_name = '%1' > vimFiles\"%1".vim
type template.vim >> vimFiles\"%1".vim
echo start gvim.exe -S "%cd%\vimFiles\%1.vim" > %cd%\vimProject\"%1".bat
echo exit >> %VIMPROJ%\vimProject\"%1".bat
echo "done!"
start dos2unix.exe vimFiles\"%1".vim
start gvim.exe vimFiles\%1.vim
)

