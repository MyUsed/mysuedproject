package member;

import java.sql.Timestamp;

public class ProfilePicDTO {

	private int pic_num;
	private int mem_num;
	private String profile_pic;
	private Timestamp reg;
	
	public int getPic_num() 	{		return pic_num;		}
	public int getMem_num() 	{		return mem_num;		}
	public String getProfile_pic(){		return profile_pic;	}
	public Timestamp getReg() 	{		return reg;			}
	
	public void setPic_num(int pic_num) 		{		this.pic_num = pic_num;		}
	public void setMem_num(int mem_num) 		{		this.mem_num = mem_num;		}
	public void setProfile_pic(String profile_pic) 	{		this.profile_pic = profile_pic;	}
	public void setReg(Timestamp reg) 			{		this.reg = reg;				}
	
	
	
}
