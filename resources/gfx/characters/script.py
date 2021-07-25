with open("nyman_hair1.anm2", "r") as src:
   lines = src.readlines()
   for i in range(2, 41):
      lines[4] = '			<Spritesheet Path="costumes\\nullcostumes\\nyman_hair%s.png" Id="0"/>\n' % i
      with open("nyman_hair%s.anm2" % i, "w") as dest:
          dest.writelines(lines)