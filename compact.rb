w=File.readlines("wordslist.txt").sample.chomp.upcase;l=w.length;v=l
while true
    if(l==0)then puts w;exit end
    g=gets.upcase;s=(0..w.size-1).count{|i|g[i]==w[i]}
    if(s==v)then puts"W";exit;else l-=1;puts"#{s.to_s}/#{v.to_s}, #{l.to_s} left";end
end
