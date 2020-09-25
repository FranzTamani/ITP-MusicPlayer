program TextBasedMusicPlayer;
uses TerminalUserInput, SysUtils, Crt;

type
	Tracks = record
		tNumber: Integer;
		tName: String;
		tLoc: String;
	end;
	
	AlbumData = record
		albumNumber: Integer;
		albumName: String;
		albumArtist: String;
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

function ReadFile(filename: String): AlbumArray;
var
	entries, i, o, k: Integer;
	musicFile: TextFile;
	aArray: AlbumArray;
	
begin
	AssignFile(musicFile, filename);
	Reset(musicFile);
	ReadLn(musicFile, entries);
	SetLength(aArray, entries);
	
	for i := 1 to entries do
	begin
		//WriteLn(i);
		ReadLn(musicFile, aArray[i].albumNumber);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumNumber);
		ReadLn(musicFile, aArray[i].albumName);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumName);
		ReadLn(musicFile, aArray[i].albumArtist);
		//WriteLn('i = ', i, ' albumArtist = ', aArray[i].albumArtist);
		ReadLn(musicFile, aArray[i].albumGenre);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumGenre);
		ReadLn(musicFile, aArray[i].albumTrackAmount);
		//WriteLn('i = ', i, ' albumNumber = ', aArray[i].albumTrackAmount);
		o := aArray[i].albumTrackAmount;
			for k := 1 to o do
			begin
				ReadLn(musicFile, aArray[i].albumTracks[k].tNumber);
				//WriteLn('tNumber = ', aArray[i].albumTracks[k].tNumber);
				ReadLn(musicFile, aArray[i].albumTracks[k].tName);
				//WriteLn('tName: ', aArray[i].albumTracks[k].tName);
				ReadLn(musicFile, aArray[i].albumTracks[k].tLoc);
				//WriteLn('tLock: ', aArray[i].albumTracks[k].tLoc);
			end;
	end;
	Close(musicFile);
    result := aArray;
end;

procedure DisplayAlbum(filename: String);
var
	aArray: AlbumArray;
	i, entries: Integer;
	musicFile: TextFile;
begin
	aArray := ReadFile(filename);
	AssignFile(musicFile, filename);
	Reset(musicFile);
	ReadLn(musicFile, entries);
	for i:= 1 to entries do
	begin
		WriteLn('Album Number: ', aArray[i].albumNumber);
	    WriteLn('Album Name: ', aArray[i].albumName);
		WriteLn('Artist Name: ', aArray[i].albumArtist);
		WriteLn('Album Genre: ', aArray[i].albumGenre);
		WriteLn('Tracks in Album: ', aArray[i].albumTrackAmount);
		WriteLn();
	end;
	Close(musicFile);
end;

procedure PlayAlbum(filename: String);
var
	aArray: AlbumArray;
	musicFile: TextFile;
	entries, i, j: Integer;
begin
	aArray := ReadFile(filename);
	AssignFile(musicFile, filename);
	Reset(musicFile);
	ReadLn(musicFile, entries);
	WriteLn();
	WriteLn('Select an Album to Play: ');
	for i := 1 to entries do
	begin
		WriteLn( aArray[i].albumNumber, '. ', aArray[i].albumName);
	end;
	i := ReadIntegerRange('Select Album: ',1, entries);
	WriteLn('You Selected', aArray[i].albumName);
	
	for j := 1 to aArray[i].albumTrackAmount do
	begin
		WriteLn(j, '. ', aArray[i].albumTracks[j].tName);
	end;
	
	j := ReadIntegerRange('Select a Song: ', 1, aArray[i].albumTrackAmount);
	
	WriteLn('Playing Track ', aArray[i].albumTracks[j].tName, ' from album ', aArray[i].albumName);
	WriteLn();
	Delay(2000);
	Close(musicFile);
end;

procedure AddAlbum(filename: String);
var
	entries, tracks, albums, c1, c2, c3: Integer;
	musicFile: TextFile;
	aArray: AlbumArray;
	song, loc, name, artist, genre: String;
begin
	aArray := ReadFile(filename);
	
	AssignFile(musicFile, filename);
	Reset(musicFile);
	//Reads how many current albums are on the file
	ReadLn(musicFile, entries);
	//Closes file so we can write
	Close(musicFile);
	
	AssignFile(musicFile, filename);
	ReWrite(musicFile);
	
	albums := entries + 1;
	
	WriteLn(musicFile, albums);
	
	for c1 := 1 to entries do
	begin
		//How Many Trakcs are in an Album//
		//tracks := aArray[c1].albumTrackAmount;
		///////////////////////////////////
		WriteLn(musicFile, aArray[c1].albumNumber);
		WriteLn(musicFile, aArray[c1].albumName);
		WriteLn(musicFile, aArray[c1].albumArtist);
		WriteLn(musicFile, aArray[c1].albumGenre);
		WriteLn(musicFile, aArray[c1].albumTrackAmount);
		
			for c2 := 1 to aArray[c1].albumTrackAmount do
			begin
				WriteLn(musicFile, aArray[c1].albumTracks[c2].tNumber);
				WriteLn(musicFile, aArray[c1].albumTracks[c2].tName);
				WriteLn(musicFile, aArray[c1].albumTracks[c2].tLoc);
			end;
	end;
	
	name := ReadString('What would you like to name your album? ');
	artist := ReadString('Who is the Artist of the album? ');
	genre := ReadString('What genre is this album? ');
	tracks := ReadIntegerRange('How many songs are in this album?(1-15) ', 1,15);
	
	WriteLn(musicFile, albums);
	WriteLn(musicFile, name);
	WriteLn(musicFile, artist);
	WriteLn(musicFile, genre);
	WriteLn(musicFile, tracks);
	
	for c3 := 1 to tracks do
	begin
		//Track Number
		WriteLn(c3);
		//Song name 
		song := ReadString('What is the name of the song? ');
		WriteLn(musicFile, song);
		//Song Location
		loc := ReadString('Where is the song located? ');
		WriteLn(musicFile, loc);
	end;
	//WriteLn('Still Working');
	
	Close(musicFile);
	
	AssignFile(musicFile, filename);
	Reset(musicFile);
	ReadFile(filename);
	Close(musicFile);
	
	//WriteLn('Closed File');
end;

//procedure SaveUpdate(var aArray: AlbumArray; filename: String);
//var
//	entries, c1, c2: Integer;
//	musicFile: TextFile;
//begin
//	AssignFile(musicFile, filename);
//	Reset(musicFile);
//	//Reads how many current albums are on the file
//	ReadLn(musicFile, entries);
//	//Closes file so we can write
//	Close(musicFile);
//	
//	AssignFile(musicFile, filename);
//	ReWrite(musicFile);
//	
//	WriteLn(musicFile, entries);
//	for c1 := 1 to entries do
//	begin
//		WriteLn(musicFile, aArray[c1].albumNumber);
//		WriteLn(musicFile, aArray[c1].albumName);
//		WriteLn(musicFile, aArray[c1].albumArtist);
//		WriteLn(musicFile, aArray[c1].albumGenre);
//		WriteLn(musicFile, aArray[c1].albumTrackAmount);
//		
//			for c2 := 1 to aArray[c1].albumTrackAmount do
//			begin
//				WriteLn(musicFile, aArray[c1].albumTracks[c2].tNumber);
//				WriteLn(musicFile, aArray[c1].albumTracks[c2].tName);
//				WriteLn(musicFile, aArray[c1].albumTracks[c2].tLoc);
//			end;
//	end;
//	Close(musicFile);
//end;

procedure UpdateAlbum(filename: String);
var
	aArray: AlbumArray;
	entries, c1: Integer;
	c4: String;
	musicFile: TextFile;
begin
	aArray := ReadFile(filename);
	
	AssignFile(musicFile, filename);
	Reset(musicFile);
	//Reads how many current albums are on the file
	ReadLn(musicFile, entries);
	//Closes file so we can write
	Close(musicFile);
	
	WriteLn();
	WriteLn('Select an Album to Update');
	for c1 := 1 to entries do
	begin
		WriteLn(aArray[c1].albumNumber);
		WriteLn(aArray[c1].albumName);
		WriteLn(aArray[c1].albumArtist);
		WriteLn(aArray[c1].albumGenre);
		WriteLn();
	end;
	c1 := ReadIntegerRange('Select an Album to Update: ', 1, entries);
	c4 := ReadString('Would you like to update the Name or Genre? ');
	
	while c4 = 'Name' do
	begin
		aArray[c1].albumName := ReadString('What would you like to change the name to? ');
		WriteLn(aArray[c1].albumName);
		c4 := 'null';
	end;
	
	while c4 = 'Genre' do
	begin
		aArray[c1].albumGenre := ReadString('What would you like to change the genre to? ');
		WriteLn(aArray[c1].albumGenre);
		c4 := 'null';
	end;
	
	//SaveUpdate(aArray, filename);
end;

procedure ExitApplication();
begin

	//File is re-written and re-read after adding new/editing albums, no need to reset in order to load new entries.
	WriteLn('Updating Albums');
	Delay(500);
end;

procedure Main();
var
	i: integer;
	filename: String;
begin

	repeat
	filename := ReadString('Enter File Name Containing Albums:(eg. filename.txt) ');
	
	if FileExists(filename) then
	
	else
	WriteLn('File Not Found');
	
	until FileExists(filename);
	
	repeat
	Startup();
	
	//i := ReadIntegerRange('Select an Option: ',1,5);
	case i of 
		//if i = 1 then
		1:
			//Add Albums
			AddAlbum(filename);
		
		//else if i = 2 then
		2:
			//Display Albums
			DisplayAlbum(filename);
		
		//else if i = 3 then
		3:
			//Play an Album
			PlayAlbum(filename);
			
		//else if i = 4 then
		4:
			//Update Album
			UpdateAlbum(filename);
		
		//until i = 5;
		5:
			Exit();
	end;
	
end;

begin
WriteLn('nani!?');
Main();
end.