function writeDat(dir, filename, x, y, z, precision, spaceX, spaceY, spaceZ)
%test function

path_dat = strcat(dir, '/', filename, '.dat');

fid = fopen(path_dat, 'w');
if (fid == -1)
    errordlg('Cannot open file %s for writing.\nYou may not have write permission.', ...
        path_dat);
end

format = 'UCHAR';
if (strcmp(precision, '*uint16'))
    format = 'USHORT';
end
if (strcmp(precision, 'float'))
    format = 'FLOAT';
end
if ~exist('spaceX','var')
     % third parameter does not exist, so default it to something
      spaceX = 1.0;
      spaceY = 1.0;
      spaceZ = 1.0;
 end

fprintf(fid, 'ObjectFileName:\t%s\n', filename);
fprintf(fid, 'TaggedFileName:\t---\nResolution:\t%i %i %i\n', x, y ,z);
fprintf(fid, 'SliceThickness:\t %.2f %.2f %.2f \n', spaceX, spaceY, spaceZ);
fprintf(fid, 'Format:\t%s\nNbrTags:\t0\n', format);
fprintf(fid, 'ObjectType:\tTEXTURE_VOLUME_OBJECT\nObjectModel:\tI\nGridType:\tEQUIDISTANT\n');
fprintf(fid, 'Modality:\tunknown\nTimeStep:\t0\n');


fclose(fid);