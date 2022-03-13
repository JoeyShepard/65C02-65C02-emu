import sys

label_list=[]
label_address=""
fr=open(sys.argv[1],"r")
fw=open(sys.argv[2],"w")
for line in fr:
    line=line[:-1]
    if line!="":
        addline=False
        address=line[13:17].strip()
        #First character of line after main listing is 12 (Form feed control character)
        if ord(line[0])==12:
            continue
        #No address means continued line or output from console, so ignore
        elif (len(address)!=0)&(len(line)>18):
            address=("0000"+address)[-4:]
            #Keep track of labels so duplicate label not added for line
            if address!=label_address:
                label_address=address
                label_list=""
            #Valid lines have colon. Check should not be necessary but just in case
            if line[18]==":":
                #Check if any bytes were laid down
                if (((line[20]>="0")&(line[20]<="9"))|((line[20]>="A")&(line[20]<="F"))):
                    if (((line[21]>="0")&(line[21]<="9"))|((line[21]>="A")&(line[21]<="F"))):
                        if (line[22]==" "):
                            addline=True
                #If no bytes laid down, check for label
                #(AS supports label without colon if in first column but assume colon here)
                if (addline==False):
                    if len(line)>=40:
                        tempstr=line[40:].strip()
                        if (tempstr.find(":")!=-1):
                            #Cut off at colon
                            tempstr=tempstr[:tempstr.find(":")]
                            #Remove leading period if exists
                            if (len(tempstr)>0):
                                if (tempstr[0]=="."):
                                    tempstr=tempstr[1:]
                                #Label can't start with a number
                                if ((tempstr[0]<"0")|(tempstr[0]>"9")):
                                    #Must contain only valid characters
                                    if (tempstr.isalnum()):
                                        #Don't output label again if already output for this line
                                        if tempstr not in label_list:
                                            label_list+=tempstr
                                            addline=True
                            
    if (addline):
        fw.write(line+"\n")

fr.close()
fw.close()
