using Core.Erp.Data.RRHH;
using Core.Erp.Info.RRHH.RDEP;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Core.Erp.Bus.RRHH
{
    public  class Rdep_Bus
    {
        Rdep_Data odata = new Rdep_Data();
        List<rdep> list_rdep = new List<rdep>();
       public List<rdep> gett_list(int IdEmpresa, int Anio, string Ruc)
             {
            try
            {
                rdep rdp = new rdep();
                rdp.anio = Anio.ToString();
                rdp.numRuc = Ruc;
                datRetRelDepTyp detalle = new datRetRelDepTyp();
                rdp.retRelDep =new List<datRetRelDepTyp>();
               var lis = odata.gett_list(IdEmpresa, Anio);
                lis.ForEach(item=>
                {
                    datRetRelDepTyp info_det = new datRetRelDepTyp();
                    info_det.empleado = new datEmpTyp();
                    info_det.empleado.benGalpg = benGalpgType.NO;
                    info_det.empleado.tipIdRet = datEmpTypTipIdRet.P;
                    info_det.empleado.idRet = item.pe_cedulaRuc;
                    info_det.empleado.apellidoTrab = item.pe_apellido;
                    info_det.empleado.nombreTrab = item.pe_nombre;
                    info_det.empleado.estab = item.Su_CodigoEstablecimiento;
                    info_det.empleado.residenciaTrab = resciTyp.Item01;
                    info_det.empleado.paisResidencia = "593";
                    info_det.empleado.aplicaConvenio = convImposTyp.NA;
                    info_det.empleado.tipoTrabajDiscap = discapTyp.Item01;
                    info_det.empleado.porcentajeDiscap = "0";
                    info_det.empleado.tipoTrabajDiscap = discapTyp.Item01;
                    info_det.empleado.idDiscap = "";

                    info_det.suelSal = ( item.Sueldo)==null?Convert.ToDecimal(0.00):Convert.ToDecimal(item.Sueldo);
                    info_det.sobSuelComRemu = (item.IngresoVarios) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.IngresoVarios);
                    info_det.partUtil = (item.Utilidades) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.Utilidades);
                    info_det.intGrabGen = (item.Sueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.Sueldo);
                    info_det.impRentEmpl = (item.Sueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.Sueldo);
                    info_det.decimTer = (item.DecimoTercerSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoTercerSueldo);
                    info_det.decimCuar = (item.DecimoCuartoSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoCuartoSueldo);
                    info_det.fondoReserva = (item.FondosReserva) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.FondosReserva);
                    info_det.salarioDigno = 0;
                    info_det.otrosIngRenGrav = 0;
                    info_det.ingGravConEsteEmpl = 0;
                    info_det.sisSalNet = "1";
                    info_det.apoPerIess = 0;
                    info_det.aporPerIessConOtrosEmpls = 0;
                    info_det.deducVivienda =  Convert.ToDecimal(item.GastoVivienda);
                    info_det.deducSalud =  Convert.ToDecimal(item.GastoSalud);
                    info_det.deducEduca =  Convert.ToDecimal(item.GastoEucacion);
                    info_det.deducAliement = Convert.ToDecimal(item.GastoAlimentacion);
                    info_det.deducVestim =  Convert.ToDecimal(item.GastoVestimenta);
                    info_det.deducArtycult = 0;
                    info_det.exoDiscap = 0;
                    info_det.exoTerEd = 0;
                    info_det.basImp = 0;
                    info_det.impRentCaus = (item.DecimoTercerSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoTercerSueldo);
                    info_det.valRetAsuOtrosEmpls = (item.DecimoTercerSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoTercerSueldo);
                    info_det.valImpAsuEsteEmpl = (item.DecimoTercerSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoTercerSueldo);
                    info_det.valRet = (item.DecimoTercerSueldo) == null ? Convert.ToDecimal(0.00) : Convert.ToDecimal(item.DecimoTercerSueldo);

                    
                    rdp.retRelDep.Add(info_det);


                });
               return list_rdep;
            }
            catch (Exception)
            {

                throw;
            }
        }
   }
}
