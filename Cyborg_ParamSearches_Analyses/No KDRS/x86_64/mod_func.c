#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _ICaL_reg(void);
extern void _ICaT_reg(void);
extern void _IKa_reg(void);
extern void _Ikdrf_reg(void);
extern void _Ikdrs_reg(void);
extern void _ingauss_reg(void);
extern void _Nap_reg(void);
extern void _Nasoma_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," ICaL.mod");
    fprintf(stderr," ICaT.mod");
    fprintf(stderr," IKa.mod");
    fprintf(stderr," Ikdrf.mod");
    fprintf(stderr," Ikdrs.mod");
    fprintf(stderr," ingauss.mod");
    fprintf(stderr," Nap.mod");
    fprintf(stderr," Nasoma.mod");
    fprintf(stderr, "\n");
  }
  _ICaL_reg();
  _ICaT_reg();
  _IKa_reg();
  _Ikdrf_reg();
  _Ikdrs_reg();
  _ingauss_reg();
  _Nap_reg();
  _Nasoma_reg();
}
