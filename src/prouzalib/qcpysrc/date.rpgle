**free

    dcl-pr get_date_by_name       varchar(100);
        p_date                    date options(*nopass);
    end-pr;

    dcl-pr get_next_working_day   date;
        p_date                    date const;
    end-pr;

    dcl-pr  int_2_date            date;
        p_date                    int(10) const;
    end-pr;