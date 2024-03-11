# from gmpy2 import invert
Gx = 0x32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7
Gy = 0xBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0
p = 0xFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF
a = 0xFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC
b = 0x28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93
n = 0xFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123

db = 0x3945208F7B2144B13F36E38AC6D39F95889393692860B51A42FB81EF4DF7C5B8
C1x = 0x04ebfc718e8d1798620432268e77feb6415e2ede0e073c0f4f640ecd2e149a73
C1y = 0xe858f9d81e5430a57b36daab8f950a3c64e6ee6a63094d99283aff767e124df0
Px = 0x09F9DF31_1E5421A1_50DD7D16_1E4BC5C6_72179FAD_1833FC07_6BB08FF3_56F35020
Py = 0xCCEA490C_E26775A5_2DC6EA71_8CC1AA60_0AED05FB_F35E084A_6632F607_2DA9AD13

# k = 0x59276E27_D506861A_16680F3A_D9C02DCC_EF3CC1FA_3CDBE4CE_6D54B80D_EAC1BC21
# k = 0xB1B6AA29_DF212FD8_763182BC_0D421CA1_BB9038FD_1F7F42D4_840B69C4_85BBC1AA
k = 0xA756E531_27F3F43B_851C47CF_EEFD9E43_A2D133CA_258EF4EA_73FBF468_3ACDA13A
Gx = C1x
Gy = C1y
k = db

# 点加
def PA(X1,X2,Z1,Z2):
    X_out = ((((X1*X2)%p-((a*Z1)%p*Z2)%p)**2)%p-((((4*b)%p*Z1)%p*Z2)%p*((X1*Z2)%p+(X2*Z1)%p))%p)%p
    Z_out = (((Gx*(((X1*Z2)%p-(X2*Z1)%p)**2)%p)%p))%p
    return X_out,Z_out

# 倍点
def PD(X1,Z1):
    # X_out = (((X**2)-a*(Z**2))**2-8*b*X*(Z**3))%p
    # Z_out = (4*Z*(X**3+a*X*Z*Z+b*Z**3))%p
    T1 = (Z1*Z1)%p
    T2 = (X1*X1)%p
    T4 = (4*b)%p 
    T3 = (a*T1)%p #aZ^2
    T4 = (T4*T1)%p #4bZ^2
    T5 = (X1*Z1)%p #XZ
    T2 = (T2-T3)%p #X^2-aZ^2
    # print(hex(T2))
    T3 = (X1*X1+a*Z1*Z1)%p #X^2+aZ^2

    # print(hex(T3))
    # print(hex((X1**2+a*Z1**2)%p))
    T1 = (T1*T4)%p #4bZ^4
    T4 = (T5*T4)%p #4bXZ^3
    T3 = (4*T3)%p #4(X^2+aZ^2)
    # print(hex(T3))
    # print(hex((4*(X1*X1+a*Z1*Z1))%p))
    # print(hex(T2))
    # print(hex(T2*T2))
    T2 = (T2*T2)%p #(X^2-aZ^2)^2
    # print(hex(T2))
    T3 = (T5*T3)%p #4XZ(X^2+aZ^2)
    T4 = (2*T4)%p #8bXZ^3
    
    X_out = (T2-T4)%p #
    Z_out = (T1+T3)%p #
    return X_out,Z_out



def     gcd(a,b):
        while a!=0:
            a,b = b%a,a
        return b
#定义一个函数，参数分别为a,n，返回值为b
def     findModReverse(a,m):#这个扩展欧几里得算法求模逆

        if gcd(a,m)!=1:
            # print(a)
            # print(m)
            return None
        u1,u2,u3 = 1,0,a
        v1,v2,v3 = 0,1,m
        while v3!=0:
            q = u3//v3
            v1,v2,v3,u1,u2,u3 = (u1-q*v1),(u2-q*v2),(u3-q*v3),v1,v2,v3
        return u1%m
# 初始化R0=G
R0_x = Gx
R0_z = 1
# R1=2G
R1_x, R1_z = PD(Gx,1)

# 253 k=0x5927 只有kG 253,其余都是254
# 254 k=0xb1b6

i = 255  # 253!!!

while(((k>>i)&1)==0):
    i = i-1
i = i - 1

# print(i)
# print(hex(R1_x))
# print(hex(R1_z))
while(i>=0):
    if(((k>>i)&1)==0):#k_i
        R1_x,R1_z = PA(R0_x,R1_x,R0_z,R1_z)
        R0_x,R0_z = PD(R0_x,R0_z)
        # print("0:",i)
        # print(hex(R0_x))
        # print(hex(R0_z))
        # print(hex(R1_x))
        # print(hex(R1_z))
    else:
        R0_x,R0_z = PA(R0_x,R1_x,R0_z,R1_z)
        R1_x,R1_z = PD(R1_x,R1_z)
        # print("1:",i)
        # print(hex(R0_x))
        # print(hex(R0_z))
        # print(hex(R1_x))
        # print(hex(R1_z))
    # print(i)
    # print(hex(R0_x))
    # print(hex(R0_z))
    # print(hex(R1_x))
    # print(hex(R1_z))

    i = i-1


# print(hex(R0_x))
# print(hex(R0_z))
# print(hex(R1_x))
# print(hex(R1_z))
x1 = (R0_x*findModReverse(R0_z,p))%p
x2 = (R1_x*findModReverse(R1_z,p))%p
y1 = (((2*b+(a+Gx*x1)*(Gx+x1)-x2*(Gx-x1)**2)%p)*(findModReverse((Gy+Gy)%p,p)))%p
# print(hex((2*b+(a+Gx*x1)*(Gx+x1)-x2*(Gx-x1)**2)%p))
# print(hex((findModReverse((Gy+Gy)%p,p))%p))
print("end")
print(hex(x1))
print(hex(y1))