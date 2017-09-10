#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _ICaL_reg(void);
extern void _ICaN_reg(void);
extern void _ICaPQ_reg(void);
extern void _ICaR_reg(void);
extern void _ICaT_reg(void);
extern void _Ih_reg(void);
extern void _IKa_reg(void);
extern void _ingauss_reg(void);
extern void _Ksoma_reg(void);
extern void _Nap_reg(void);
extern void _Nasoma_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," ICaL.mod");
    fprintf(stderr," ICaN.mod");
    fprintf(stderr," ICaPQ.mod");
    fprintf(stderr," ICaR.mod");
    fprintf(stderr," ICaT.mod");
    fprintf(stderr," Ih.mod");
    fprintf(stderr," IKa.mod");
    fprintf(stderr," ingauss.mod");
    fprintf(stderr," Ksoma.mod");
    fprintf(stderr," Nap.mod");
    fprintf(stderr," Nasoma.mod");
    fprintf(stderr, "\n");
  }
  _ICaL_reg();
  _ICaN_reg();
  _ICaPQ_reg();
  _ICaR_reg();
  _ICaT_reg();
  _Ih_reg();
  _IKa_reg();
  _ingauss_reg();
  _Ksoma_reg();
  _Nap_reg();
  _Nasoma_reg();
}
