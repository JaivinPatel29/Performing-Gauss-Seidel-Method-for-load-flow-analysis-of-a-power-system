clear all
clc
lfdata
[y_bus]=ybus(line_data,bus_shunt)
n_buses = max(max(line_data(:,1:2)))
sl = find(bus_data(:,2)==0)
pv = find(bus_data(:,2)==1)
pq = find(bus_data(:,2)==2)
sl_l=size(sl,1)
pv_l=size(pv,1)
pq_l=size(pq,1)
vmag=bus_data(:,3);
ang=bus_data(:,4);
[vr,vi]=pol2cart(ang,vmag);
v=complex(vr,vi);
s=-bus_data(:,6);
for iter= 1:500
    for i = 1 : pq_l
        a=1/y_bus(pq(i),pq(i))
        b=conj(s(pq(i)))/conj(v(pq(i)))
        sum=0
        for k = 1 : n_buses
            if (pq(i)~=k)
                sum=sum+(y_bus(pq(i),k)*v(k))
            end
        end
        v_temp=a*(b-sum)
        v_change(pq(i))=abs(v(pq(i)))-abs(v_temp)
        v(pq(i))=v_temp;
    end
    for i = 1 : pv_l
        i_temp=y_bus*v
        ik_temp=i_temp(pv(i))
        q_temp=-imag(conj(v(pv(i)))*ik_temp)
        if bus_data(pv(i),8)<q_temp<bus_data(pv(i),7)
        s_temp=complex(bus_data(pv(i),5),q_temp)
        else if bus_data(pv(i),8)>q_temp
                s_temp=complex(bus_data(pv(i),5),bus_data(pv(i),8))
        else
            s_temp=complex(bus_data(pv(i),5),bus_data(pv(i),7))
        end
        end
   
        a=1/y_bus(pv(i),pv(i))
        b=conj(s_temp)/conj(v(pv(i)))
        sum=0
        for k = 1 : n_buses
            if (pv(i)~=k)
                sum=sum+(y_bus(pv(i),k)*v(k))
            end
        end
        v_temp=a*(b-sum)
        angle_temp=angle(v_temp)
        mag_temp=abs(v(pv(i)))
        [x_temp,y_temp]=pol2cart(angle_temp,mag_temp)
        v_temp=complex(x_temp,y_temp)
     %   ttt=abs(v_temp)
     %   tttt=angle(v_temp)
        v_change(pv(i))=angle(v(pv(i)))-angle(v_temp)
        v(pv(i))=v_temp;
 
    end
         mag_change=abs(v_change)
         ang_change=abs(angle(v_change))
        max_change=max(max(mag_change),max(ang_change))
       % max_change=max(abs(v_change))
        if max_change < 0.0001
            iter
            break
        end
end
