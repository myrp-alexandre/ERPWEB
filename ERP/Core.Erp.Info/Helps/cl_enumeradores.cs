using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Helps
{
    public class cl_enumeradores
    {
        public enum eTipoCatalogoGeneral
        {
            SEXO = 1,
            ESTCIVIL = 2,
            TIPODOC = 3,
            TIPONATPER = 5,
            TIP_CTA_AC = 27
        }

        public enum eTipoCatalogoInventario
        {
            EST_APROB = 1,
            FECH_CONTA = 4,
            TIPO_CONTA_CTA = 6,
            ING_EGR = 8
        }
        
        public enum eEstadoEmpleadoRRHH
        {
            EST_ACT=1,
            EST_DES=2,
            EST_INC=3,
            EST_LIQ=4,
            EST_PER=5,
            EST_PLQ=6,
            EST_SUB=7,
            EST_VAC=8,
            EST_VB=9,

        }
        public enum eEstadoContratoRRHH
        {
            ECT_ACT = 1,
            ECT_LIQ = 2           
        }
        public enum eTipoPeriodoRRHH
        {
            BEN_SOCIAL,
            MEN,
            QUINCE,
            SEM
        }

        public enum eTipoIngEgr
        {
            ING,
            EGR
        }

        public enum eCobroTipoMotivoCuentasPorCobrar
        {
            CHEQ=1,
            COMI_TAR=2,
            DEPO=3,
            EFEC=4,
            NTCR=5,
            NTDB=6,
            RET=7,
            TARJ=8,
            TRANS_BAN=9
        }

        public enum eTipoCatalogoAF
        {
            TIP_COLOR,
            TIP_MODELO,
            TIP_ESTADO_AF,
            TIP_MARCA,
            TIP_UBICACION
        }
        
        public enum eTipoMejBajAF
        {
            Mejo_Acti,
            Baja_Acti
        }

        public enum eTipoPersona
        {
            CLIENTE,
            EMPLEA,
            PERSONA,
            PROVEE
        }
    }
}
