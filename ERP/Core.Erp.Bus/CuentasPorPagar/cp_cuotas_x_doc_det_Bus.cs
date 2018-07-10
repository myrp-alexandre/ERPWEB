using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
using Core.Erp.Data.CuentasPorPagar;
namespace Core.Erp.Bus.CuentasPorPagar
{
   public class cp_cuotas_x_doc_det_Bus
    {
        cp_cuotas_x_doc_det_Data oData = new cp_cuotas_x_doc_det_Data();
        public List<cp_cuotas_x_doc_det_Info> Get_list_cuotas_x_doc_det(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                return oData.Get_list_cuotas_x_doc_det(IdEmpresa, IdCuota);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool EliminarDB(int IdEmpresa, decimal IdCuota)
        {
            try
            {
                return oData.EliminarDB(IdEmpresa, IdCuota);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool GuardarDB(List<cp_cuotas_x_doc_det_Info> Lista)
        {
            try
            {
                return oData.GuardarDB(Lista);
            }
            catch (Exception )
            {
                throw;
            }
        }

        public bool ModificarDB_campos_op(cp_cuotas_x_doc_det_Info info)
        {
            try
            {
                return oData.ModificarDB_campos_op(info);
            }
            catch (Exception )
            {
                throw;
            }
        }
        public List<cp_cuotas_x_doc_det_Info>calcular_cuotas(DateTime Fecha_inicio, int Num_cuotas = 0, int Dias_plazo = 0, double Total_a_pagar = 0)
        {
            try
            {
                List<cp_cuotas_x_doc_det_Info> lst_cuotas = new List<cp_cuotas_x_doc_det_Info>();
                int contador = 1;
                DateTime fecha = Fecha_inicio;
                while (contador <=Num_cuotas)
                {
                    cp_cuotas_x_doc_det_Info info = new cp_cuotas_x_doc_det_Info();
                    info.Secuencia = contador;
                    info.Num_cuota = contador;
                    if (contador == 1)
                        info.Fecha_vcto_cuota = Fecha_inicio;
                    else
                        info.Fecha_vcto_cuota = fecha;
                    info.Valor_cuota = Total_a_pagar / Num_cuotas;
                    info.Observacion = "Cuota # " + contador + " vence el " + info.Fecha_vcto_cuota.Date.ToString().Substring(0,10);
                    contador++;
                    fecha = fecha.AddDays(Dias_plazo);
                    lst_cuotas.Add(info);
                }

                return lst_cuotas;
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
