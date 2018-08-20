using Core.Erp.Info.Reportes.CuentasPorCobrar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.CuentasPorCobrar
{
    public class CXC_004_Data
    {
        public List<CXC_004_Info> get_list(int IdEmpresa, decimal IdCliente, int IdContacto, DateTime fecha_corte, string Estado)
        {
            try
            {
                decimal IdCliente_ini = IdCliente;
                decimal IdCliente_fin = IdCliente == 0 ? 999999 :  IdCliente;

                int IdContacto_ini = IdContacto;
                int IdContacto_fin = IdContacto == 0 ? 9999 : IdContacto;

                fecha_corte = fecha_corte.Date;
                List<CXC_004_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.SPCXC_004(IdEmpresa, IdCliente_ini, IdCliente_fin, IdContacto_ini, IdContacto_fin, fecha_corte)
                             where q.Estado_documento.Contains(Estado)
                             select new CXC_004_Info
                             {
                                 IdRow = q.IdRow,
                                 IdEmpresa = q.IdEmpresa, 
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 vt_fecha = q.vt_fecha,
                                 vt_NumFactura = q.vt_NumFactura,
                                 vt_Observacion = q.vt_Observacion,
                                 vt_tipoDoc = q.vt_tipoDoc,
                                 valor_doc = q.valor_doc,
                                 valor = q.valor,
                                 Debito = q.Debito,
                                 Credito = q.Credito,
                                 saldo = q.saldo,
                                 IdCliente = q.IdCliente,
                                 pe_nombreCompleto = q.pe_nombreCompleto,
                                 Estado = q.Estado,
                                 Tipo_cbte = q.Tipo_cbte,
                                 orden = q.orden,
                                 Tipo_cobro = q.Tipo_cobro,
                                 num_documento_cobro = q.num_documento_cobro,
                                 IdCobro = q.IdCobro,
                                 Estado_documento = q.Estado_documento,
                                 cr_observacion = q.cr_observacion,
                                 IdContacto = q.IdContacto,
                                 NomContacto = q.NomContacto
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
