program TextBasedMusicPlayer;
uses TerminalUserInput;

//const 
//	filename = 'musicfile.dat';

type
	Tracks = record
		tNumber: Integer;
		tName: String;
		tLoc: String;
	end;
	
	AlbumData = record
		albumNumber: Integer;
		albumName: String;
		albumGenre: String;
		albumTrackAmount: Integer;
		albumTracks: array [1..15] of Tracks;
	end;
	
	AlbumArray = Array of AlbumData;


procedure Startup();
begin
	WriteLn();
	WriteLn('Main Menu');
	WriteLn('1. Add Albums');
	WriteLn('2. Display Albums');
	WriteLn('3. Select an Album to Play');
	WriteLn('4. Update an Existing Album');
	WriteLn('5. Exit Application');
	WriteLn();
end;

procedure PrintAlbums(aArray: AlbumArray; count: Integer);
var
	i: Integer;
begin
	WriteLn();
	for i := 1 to count do
	begin
		WriteLn(aArray[i].albumNumber);
	    WriteLn(aArray[i].albumName);
		WriteLn(aArray[i].albumGenre);
		WriteLn(aArray[i].albumTrackAmount);
		WriteLn();
	end;
 end;

procedure ReadFile();
var
	musicFile: TextFile;
    aArray: AlbumArray;
    i, o, number, entries: Integer;
begin
	AssignFile(musicFile, 'musicfile.dat');
	Reset(musicFile);
	ReadLn(musicFile, entries);
	number := entries;
	SetLength(aArray, entries);
	for i := 1 to entries do
	begin
		//WriteLn(i);
		ReadLn(musicFile, aArray[i].albumNumber);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumNumber);
		ReadLn(musicFile, aArray[i].albumName);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumName);
		ReadLn(musicFile, aArray[i].albumGenre);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumGenre);
		ReadLn(musicFile, aArray[i].albumTrackAmount);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumTrackAmount);
		o := aArray[i].albumTrackAmount;
			while o > 0 do
			begin
				ReadLn(musicFile, aArray[i].albumTracks[o].tNumber);
				//WriteLn('tNumber = ', aArray[i].albumTracks[o].tNumber);
				ReadLn(musicFile, aArray[i].albumTracks[o].tName);
				//WriteLn('tName: ', aArray[i].albumTracks[o].tName);
				ReadLn(musicFile, aArray[i].albumTracks[o].tLoc);
				//WriteLn('tLock: ', aArray[i].albumTracks[o].tLoc);
				o := o - 1;
			end;
	end;
	WriteLn();
	
	for i := 1 to number do
	begin
		WriteLn('Album Number: ', aArray[i].albumNumber);
	    WriteLn('Album Name: ', aArray[i].albumName);
		WriteLn('Album Genre: ', aArray[i].albumGenre);
		WriteLn('Tracks in Album: ', aArray[i].albumTrackAmount);
		WriteLn();
	end;
	
	//PrintAlbums(aArray, number);
end;
 
//procedure DisplayAlbums();
//var
//	musicFile: TextFile;
//	
//begin
//	AssignFile(musicFile, 'musicfile.dat');
//	Reset(musicFile);
//	ReadFile(musicFile);
//	Close(musicFile);
//end;


procedure Main();
var
	i: Integer;
	
begin

	repeat
	
	Startup();
	i := ReadIntegerRange('Select Option: ', 1, 5);
	
	if i = 1 then
	
		//Read in Albums
		WriteLn(1)
		
	else if i = 2 then
	
		//Display Albums
		ReadFile()
		
	else if i = 3 then
	
		//Select Album to Play
		WriteLn(3)

	else if i = 4 then
	
		//Update Existing Album
		WriteLn(4);
		 
	until i = 5;
	
	
	//Prompts user to enter a file name
	//q := ReadString('File Name Containing Album Data:');
	//filename := Concat();
	
	
end;

begin
	Main();
end.