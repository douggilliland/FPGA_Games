#ifndef __SHIFT_CLASS__
#define __SHIFT_CLASS__

template<typename dataType, int NUM_REGS>
class shift_class{
private:
    dataType regs[NUM_REGS];
    bool en;
    bool sync_rst;
    bool ld;
    dataType *load_data;
public:
    shift_class():en(true),sync_rst(false),ld(false){}
    shift_class(dataType din[NUM_REGS]):
    en(true),sync_rst(false),ld(false){ load_data = din; }

    void set_sync_rst(bool srst)
    {
        sync_rst = srst;
    }

    void load(bool load_in)
    {
        ld = load_in;
    }

    void set_enable(bool enable)
    {
        en = enable;
    }

    void operator << (dataType din)
    {
    SHIFT:for(int i=NUM_REGS-1;i>=0;i--){
    if(en)
        if(sync_rst)
            regs[i] = 0;
        else if(ld)
            regs[i] = load_data[i];
        else
        if(i==0)
            regs[i] = din;
        else
            regs[i] = regs[i-1];
        }
    }

    dataType operator [](int i)
    {
        return regs[i];
    }
};

#endif
