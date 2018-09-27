#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _CalciumP_reg(void);
extern void _CaP_reg(void);
extern void _CaP2_reg(void);
extern void _CaT_reg(void);
extern void _K2_reg(void);
extern void _K22_reg(void);
extern void _K23_reg(void);
extern void _KA_reg(void);
extern void _KC_reg(void);
extern void _KC2_reg(void);
extern void _KC3_reg(void);
extern void _KD_reg(void);
extern void _Kdr_reg(void);
extern void _Kh_reg(void);
extern void _Khh_reg(void);
extern void _KM_reg(void);
extern void _Leak_reg(void);
extern void _CaE_reg(void);
extern void _NaF_reg(void);
extern void _NaP_reg(void);
extern void _pj_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," CalciumP.mod");
    fprintf(stderr," CaP.mod");
    fprintf(stderr," CaP2.mod");
    fprintf(stderr," CaT.mod");
    fprintf(stderr," K2.mod");
    fprintf(stderr," K22.mod");
    fprintf(stderr," K23.mod");
    fprintf(stderr," KA.mod");
    fprintf(stderr," KC.mod");
    fprintf(stderr," KC2.mod");
    fprintf(stderr," KC3.mod");
    fprintf(stderr," KD.mod");
    fprintf(stderr," Kdr.mod");
    fprintf(stderr," Kh.mod");
    fprintf(stderr," Khh.mod");
    fprintf(stderr," KM.mod");
    fprintf(stderr," Leak.mod");
    fprintf(stderr," CaE.mod");
    fprintf(stderr," NaF.mod");
    fprintf(stderr," NaP.mod");
    fprintf(stderr," pj.mod");
    fprintf(stderr, "\n");
  }
  _CalciumP_reg();
  _CaP_reg();
  _CaP2_reg();
  _CaT_reg();
  _K2_reg();
  _K22_reg();
  _K23_reg();
  _KA_reg();
  _KC_reg();
  _KC2_reg();
  _KC3_reg();
  _KD_reg();
  _Kdr_reg();
  _Kh_reg();
  _Khh_reg();
  _KM_reg();
  _Leak_reg();
  _CaE_reg();
  _NaF_reg();
  _NaP_reg();
  _pj_reg();
}
